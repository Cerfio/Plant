export interface IEmailAvailableInput {
  email: string;
}

export const emailAvailableQuerySchema = {
  type: 'object',
  required: ['email'],
  properties: {
    email: { type: 'string', format: 'email' },
  },
};
