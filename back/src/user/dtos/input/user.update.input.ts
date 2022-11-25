export const userUpdateBodySchema = {
  type: 'object',
  properties: {
    firstname: { type: 'string' },
    lastname: { type: 'string' },
    email: { type: 'string', format: 'email' },
    numberPhone: { type: 'string' },
    password: { type: 'string', minLength: 8 },
    confirmPassword: { type: 'string', minLength: 8 },
  },
};
