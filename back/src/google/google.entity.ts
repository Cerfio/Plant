export interface IGoogleUserInfo {
  _id: string;
  email: string;
  verified_email: boolean;
  name: string;
  given_name: string;
  family_name: string;
  picture: string | null;
  locale: string;
}

export interface IGoogleToken {
  access_token: string;
  expires_in: number;
  scope: string;
  token_type: string;
  id_token: string;
}

export interface IGoogleFile {
  kind: string;
  object: string;
  generation: string;
  id: string;
  selfLink: string;
  bucket: string;
  entity: string;
  role: string;
  etag: string;
}
