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

#ifndef MQTTClient_h
#define MQTTClient_h

#include "Client.h"
#include "CooperativeMultitasking.h"

class MQTTClient {
  friend class MQTTTopic;

  private:
    struct PublishPacket {
      bool retain;
      const char* topicname;
      char* payload;
      uint16_t packetid;
      uint16_t trycount;
      PublishPacket* next;
    };

    static MQTTClient* current;

    CooperativeMultitasking* tasks;
    Client* client;
    char* host;
    uint16_t port;
    char* clientid;
    char* username;
    char* password;
    uint16_t keepalive;
    bool isconnected;
    PublishPacket* head;
    PublishPacket* tail;

    void enqueuePublishPacket(PublishPacket* packet);
    void transmitPublishPacketsAfter(unsigned long duration);
    void transmitPublishPackets();
    void removePublishPacket(uint16_t packetid);
    void rotatePublishPackets();

    bool sendConnectPacket();
    void receiveConnectAcknowledgementPacket();
    bool sendHeadPublishPacket();
    void receivePublishAcknowledgementPacket();
    void sendDisconnectPacket();

    void writeTypeFlags(uint8_t type, uint8_t flags);
    void writePacketLength(int value);
    void writeLengthString(const char* value);
    void writeString(const char* value, size_t len);
    void writeShort(uint16_t value);
    void writeByte(uint8_t value);
    uint8_t readByte();
    uint16_t readShort();

    void flush();
    int getWriteError();
    int available();
    void stop();

    static char* strdupOrNull(const char* string);

  protected:
    bool publish(bool retain, const char* topicname, const char* payload);

  public:
    MQTTClient(CooperativeMultitasking* tasks, Client* client, const char* host, uint16_t port, const char* clientid, const char* username, const char* password, uint16_t keepalive = 300);
    virtual ~MQTTClient();
    bool connect();
    bool connected();
    bool publishAcknowledged();
    void disconnect();
};

class MQTTTopic {
  private:
    MQTTClient* client;
    char* topicname;
    bool retain;

  public:
    MQTTTopic(MQTTClient* client, const char* topicname);
    virtual ~MQTTTopic();
    bool publish(const char* payload, bool retain = true);
};

#endif