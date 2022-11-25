/*
 * Copyright (C) 2018 Andreas Motzek andreas-motzek@t-online.de
 *
 * This file is part of the MQTT Client package.
 *
 * You can use, redistribute and/or modify this file under the terms of the Modified Artistic License.
 * See http://simplysomethings.de/open+source/modified+artistic+license.html for details.
 *
 * This file is distributed in the hope that it will be useful, but without any warranty; without even
 * the implied warranty of merchantability or fitness for a particular purpose.
 */

#include "MQTTClient.h"

MQTTClient* MQTTClient::current = NULL;

MQTTClient::MQTTClient(CooperativeMultitasking* _tasks, Client* _client, const char* _host, uint16_t _port, const char* _clientid, const char* _username, const char* _password, uint16_t _keepalive) {
  tasks = _tasks;
  client = _client;
  host = strdup(_host);
  port = _port;
  clientid = strdup(_clientid);
  username = strdupOrNull(_username);
  password = strdupOrNull(_password);
  keepalive = _keepalive;
  isconnected = false;
  head = NULL;
  tail = NULL;
}

MQTTClient::~MQTTClient() {
  free(host);
  free(clientid);
  free(username);
  free(password);
  host = NULL;
  clientid = NULL;
  username = NULL;
  password = NULL;
  //
  while (head) {
    PublishPacket* next = head->next;
    free(head->payload);
    delete head;
    head = next;
  }
  //
  tail = NULL;
  //
  if (current == this) current = NULL;
}

bool MQTTClient::connect() {
  if (!current) {
    if (client->connect(host, port)) {
      if (sendConnectPacket()) {
        current = this;
        auto task1 = tasks->ifThen([] () -> bool { return current ? current->available() >= 4 : true; },
                                   [] () -> void { if (current) current->receiveConnectAcknowledgementPacket(); });
        auto task2 = tasks->after(10000, [] () -> void { if (current) current->stop(); });
        tasks->onlyOneOf(task1, task2);
        //
        return true;
      }
      //
      Serial.println("cannot send connect packet");
      //
      stop();
    } else {
      Serial.print("cannot connect to ");
      Serial.print(host);
      Serial.print(":");
      Serial.println(port);
    }
  } else {
    Serial.println("another mqtt client is connected");
  }
  //
  return false;
}

bool MQTTClient::connected() {
  return isconnected;
}

bool MQTTClient::publishAcknowledged() {
  return !head;
}

bool MQTTClient::publish(bool retain, const char* topicname, const char* payload) {
  PublishPacket* packet = new PublishPacket(); // std::nothrow is default
  //
  if (packet) {
    packet->retain = retain;
    packet->topicname = topicname;
    packet->payload = strdup(payload);
    enqueuePublishPacket(packet);
    transmitPublishPacketsAfter(0);
    //
    return true;
  }
  //
  Serial.println("cannot enqueue publish packet");
  //
  return false;
}

void MQTTClient::disconnect() {
  if (isconnected) sendDisconnectPacket();
  //
  stop();
}

void MQTTClient::enqueuePublishPacket(PublishPacket* packet) {
  uint16_t packetid = 1; // 2.3.1 non-zero 16-bit packetid
  //
  if (head) {
    PublishPacket* packet = head;
    //
    while (packet) {
      if (packet->packetid > packetid) packetid = packet->packetid;
      //
      packet = packet->next;
    }
    //
    packetid++; // biggest packetid plus 1
  }
  //
  packet->packetid = packetid;
  packet->trycount = 0;
  packet->next = head;
  head = packet;
  //
  if (!tail) tail = head;
}

void MQTTClient::transmitPublishPacketsAfter(unsigned long duration) {
  tasks->after(duration, [] () -> void { if (current) current->transmitPublishPackets(); });
}

void MQTTClient::transmitPublishPackets() {
  if (isconnected && current == this && head) {
    if (available() >= 4) {
      receivePublishAcknowledgementPacket();
      transmitPublishPacketsAfter(100);
      //
      return;
    }
    //
    if (head->trycount >= 20) {
      Serial.println("discarding packet");
      //
      removePublishPacket(head->packetid);
      transmitPublishPacketsAfter(100);
      //
      return;
    }
    //
    if (sendHeadPublishPacket()) {
      head->trycount++;
      rotatePublishPackets();
      transmitPublishPacketsAfter(10000);
      //
      return;
    }
    //
    Serial.println("cannot send publish packet");
    //
    stop();
  }
}

void MQTTClient::removePublishPacket(uint16_t packetid) {
  PublishPacket* last = NULL;
  PublishPacket* packet = head;
  //
  while (packet) {
    if (packet->packetid == packetid) {
      if (last) last->next = packet->next;
      //
      if (packet == head) head = packet->next;
      //
      if (packet == tail) tail = last;
      //
      free(packet->payload);
      delete packet;
      //
      return;
    }
    //
    last = packet;
    packet = packet->next;
  }
}

void MQTTClient::rotatePublishPackets() {
  if (!head || head == tail) return; // less than 2 packets
  //
  tail->next = head;
  tail = head;
  head = head->next;
  tail->next = NULL;
}

bool MQTTClient::sendConnectPacket() {
  int packetlength = 2 + 4 + 1 + 1 + 2 + 2 + strlen(clientid);
  //
  if (username != NULL) packetlength += (2 + strlen(username));
  //
  if (password != NULL) packetlength += (2 + strlen(password));
  //
  uint8_t connectflags = 2; // clean session
  //
  if (username != NULL) connectflags |= 128;
  //
  if (password != NULL) connectflags |= 64;
  //
  // Type, Flags, Packet Length
  writeTypeFlags(1, 0); // connect, 0
  writePacketLength(packetlength);
  //
  // Header
  writeLengthString("MQTT"); // protocol name
  writeByte(4); // protocol level
  writeByte(connectflags);
  writeShort(keepalive);
  //
  // Payload
  writeLengthString(clientid);
  //
  if (username != NULL) writeLengthString(username);
  //
  if (password != NULL) writeLengthString(password);
  //
  flush();
  //
  return !getWriteError();
}

void MQTTClient::receiveConnectAcknowledgementPacket() {
  uint8_t typeflags = readByte();
  uint8_t packetlength = readByte();
  uint8_t sessionpresent = readByte();
  uint8_t returncode = readByte();
  //
  if (typeflags == (2 << 4) && packetlength == 2) {
    switch (returncode) {
      case 0: Serial.println("connection accepted"); isconnected = true; transmitPublishPacketsAfter(0); return;
      case 1: Serial.println("unacceptable protocol version"); break;
      case 2: Serial.println("identifier rejected"); break;
      case 3: Serial.println("server unavailable"); break;
      case 4: Serial.println("bad user name or password"); break;
      case 5: Serial.println("not authorized"); break;
      default: Serial.println(returncode); break;
    }
  } else {
    Serial.println("not a connect acknowledgement");
  }
  //
  stop();
}

bool MQTTClient::sendHeadPublishPacket() {
  int packetlength = 2 + strlen(head->topicname) + 2 + strlen(head->payload);
  uint8_t flags = 2; // QoS 1
  //
  if (head->trycount > 0) flags |= 8; // duplicate
  //
  if (head->retain) flags |= 1;
  //
  // Type, Flags, Packet Length
  writeTypeFlags(3, flags); // publish, flags
  writePacketLength(packetlength);
  //
  // Header
  writeLengthString(head->topicname);
  writeShort(head->packetid);
  //
  // Payload
  writeString(head->payload, strlen(head->payload));
  //
  flush();
  //
  return !getWriteError();
}

void MQTTClient::receivePublishAcknowledgementPacket() {
  uint8_t typeflags = readByte();
  uint8_t packetlength = readByte();
  uint16_t packetid = readShort();
  //
  if (typeflags == (4 << 4) && packetlength == 2) {
    removePublishPacket(packetid);
    //
    Serial.println("publish acknowledged");
    //
    return;
  }
  //
  Serial.println("not a publish acknowledgement");
  disconnect();
}

void MQTTClient::sendDisconnectPacket() {
  // Type, Flags, Packet Length
  writeTypeFlags(14, 0); // disconnect, 0
  writePacketLength(0);
  //
  flush();
}

void MQTTClient::writeTypeFlags(uint8_t type, uint8_t flags) {
  writeByte(type << 4 | flags);
}

void MQTTClient::writePacketLength(int value) {
  while (true) {
    int digit = value & 127;
    value >>= 7;
    //
    if (value > 0) {
      writeByte(digit | 128);
    } else {
      writeByte(digit);
      //
      break;
    }
  }
}

void MQTTClient::writeLengthString(const char* value) {
  size_t len = strlen(value);
  //
  if (len > 65535) return;
  //
  writeShort(len);
  writeString(value, len);
}

void MQTTClient::writeString(const char* value, size_t len) {
  client->write((uint8_t*) value, len);
}

void MQTTClient::writeShort(uint16_t value) {
  writeByte(value >> 8);
  writeByte(value & 255);
}

void MQTTClient::writeByte(uint8_t value) {
  client->write(value);
}

void MQTTClient::flush() {
  client->flush();
}

int MQTTClient::getWriteError() {
  return client->getWriteError();
}

int MQTTClient::available() {
  return client->available();
}

uint8_t MQTTClient::readByte() {
  return client->read();
}

uint16_t MQTTClient::readShort() {
  uint16_t value = client->read();
  value <<= 8;
  value += client->read();
  //
  return value;
}

void MQTTClient::stop() {
  if (client->connected()) {
    client->stop();
    client->clearWriteError();
  }
  //
  isconnected = false;
  current = NULL;
}

char* MQTTClient::strdupOrNull(const char* string) {
  if (string == NULL) return NULL;
  //
  return strdup(string);
}

/*
 *
 */

MQTTTopic::MQTTTopic(MQTTClient* _client, const char* _topicname) {
  client = _client;
  topicname = strdup(_topicname);
}

MQTTTopic::~MQTTTopic() {
  free(topicname);
  topicname = NULL;
}

bool MQTTTopic::publish(const char* payload, bool retain) {
  return client->publish(retain, topicname, payload);
}
