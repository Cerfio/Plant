export interface ISignInInput {
  email: string;
  password: string;
}

export const signInBodySchema = {
  type: 'object',
  required: ['email', 'password'],
  properties: {
    email: { type: 'string', format: 'email' },
    password: { type: 'string' },
  },
};
