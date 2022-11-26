import axios from '../config/axios';

export interface SignInInput {
  email: string;
  password: string;
}

export const signIn = async ({ email, password }: SignInInput) => {
  const response = await axios.post('/auth/signin', { email, password });
  return response.data;
};
