export const userUpdatePasswordBodySchema = {
  type: 'object',
  required: ['password'],
  properties: {
    password: { type: 'string', minLength: 8 },
  },
};
