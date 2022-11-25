export const authGoogleResponseSchema = {
  '2xx': {
    type: 'object',
    properties: {
      token: { type: 'string' },
    },
  },
};
