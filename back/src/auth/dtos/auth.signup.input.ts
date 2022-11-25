export interface ISignUpInput {
  firstname: string;
  lastname: string;
  email: string;
  password: string;
}

export const signUpBodySchema = {
  type: 'object',
  required: ['firstname', 'lastname', 'email', 'password'],
  properties: {
    firstname: { type: 'string' },
    lastname: { type: 'string' },
    email: { type: 'string', format: 'email' },
    password: { type: 'string', minLength: 8 },
  },
};
