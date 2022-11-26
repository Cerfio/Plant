import axios from '../config/axios';
import { useQuery } from '@tanstack/react-query';

export interface UsersOutput {
  id: string;
  email: string;
  firstname: string;
  lastname: string;
  admin: boolean;
}

// export const getUsers = async () => {
//   const response = await axios.get<UsersOutput>('/users');
//   return response.data;
// };

export const getUsers = () => {
  return useQuery({
    queryKey: ['users'],
    queryFn: async () => {
      const { data } = await axios.get<UsersOutput[]>('/users');
      return data;
    }
  });
}
