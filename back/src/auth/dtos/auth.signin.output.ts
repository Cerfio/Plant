export const signInResponseSchema = {
  '2xx': {
    type: 'object',
    properties: {
      message: { type: 'string' },
    },
  },
};
