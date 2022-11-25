const schema = {
  type: "object",
  required: [],
  properties: {
    PORT: {
      type: "string",
      default: 3003,
    },
    SECRET_JWT: {
      type: "string",
      default: "secretjwt",
    },
    SALT_ROUNDS: {
      type: "number",
      default: 10,
    },
    GOOGLE_PROJECT_ID: {
      type: "string",
    },
    GOOGLE_KEYFILE: {
      type: "string",
    },
    BUCKET_MEDIA: {
      type: "string",
    },
    SENDGRID_API_KEY: {
      type: "string",
    },
  },
};

export const options = {
  dotenv: true,
  schema: schema,
};
