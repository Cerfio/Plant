export interface IAuthGoogleInput {
  code: string;
}

export const authGoogleBodySchema = {
  type: 'object',
  required: ['code'],
  properties: {
    code: { type: 'string' },
  },
};
