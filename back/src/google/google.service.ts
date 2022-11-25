import axios from 'axios';
import querystring from 'querystring';
import { Storage } from '@google-cloud/storage';
import { LogTaskService } from './../../common/LogTask';
import {
  GoogleDeleteError,
  GoogleGetAccessTokenError,
  GoogleUploadError,
  GoogleUserInfoError,
} from './google.exceptions';
import { IGoogleToken, IGoogleUserInfo } from './google.entity';
import { File } from 'fastify-multer/lib/interfaces';

const fs = require('fs');
const { promisify } = require('util');

const unlinkAsync = promisify(fs.unlink);
const storage = new Storage({ projectId: process.env.GOOGLE_PROJECT_ID, keyFilename: process.env.GOOGLE_KEYFILE });

export class GoogleService {
  logTask: LogTaskService = new LogTaskService('GoogleService');
  constructor(readonly server: any) {}

  getAccessTokenFromCode = async (code: string): Promise<string> => {
    this.logTask.start('getAccessTokenFromCode');

    try {
      const data = await axios.post<IGoogleToken>(
        `https://oauth2.googleapis.com/token`,
        querystring.stringify({
          client_id: this.server.config.GOOGLE_CLIENT_ID,
          client_secret: this.server.config.GOOGLE_CLIENT_SECRET,
          redirect_uri: `${this.server.config.FRONT_URL}/google/oauth2`,
          grant_type: 'authorization_code',
          code,
        }),
      );
      this.logTask.end('getAccessTokenFromCode');
      return data.data.access_token;
    } catch (e) {
      throw new GoogleGetAccessTokenError(this.server, this.logTask, e, true);
    }
  };

  getGoogleUserInfo = async (access_token: string) => {
    try {
      const { data } = await axios.get<IGoogleUserInfo>('https://www.googleapis.com/oauth2/v2/userinfo', {
        headers: {
          Authorization: `Bearer ${access_token}`,
        },
      });
      return data;
    } catch (e) {
      throw new GoogleUserInfoError(this.server, this.logTask, e, true);
    }
  };

  upload = async (file: File, uniqueFilename: string, bucketName: string) => {
    this.logTask.start('upload');
    try {
      const bucket = storage.bucket(bucketName);
      const { filename } = file;

      const options = {
        destination: uniqueFilename,
        resumable: true,
        metadata: {
          contentType: file.mimetype,
        },
      };
      await bucket.upload(`./uploads/${filename}`, options);
      const bucketFile = await bucket.file(uniqueFilename).makePublic();
      await unlinkAsync(`./uploads/${filename}`);
      this.logTask.end('upload');
      return bucketFile;
    } catch (e) {
      throw new GoogleUploadError(this.server, this.logTask, e, true);
    }
  };

  delete = async (file: { bucket: string; gcpId: string }) => {
    this.logTask.start('delete');
    try {
      const bucket = storage.bucket(file.bucket);
      await bucket.file(file.gcpId).delete();
      this.logTask.end('delete');
      return true;
    } catch (e) {
      throw new GoogleDeleteError(this.server, this.logTask, e, true);
    }
  };
}
