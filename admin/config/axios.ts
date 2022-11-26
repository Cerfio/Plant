import axios, { AxiosRequestConfig } from 'axios';
import router from 'next/router';
import { getToken } from '../cookies/User';

const instance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_BACK_URL,
  headers: {
    common: {
      'Content-Type': 'application/json'
    }
  },
  timeout: 10000
});

instance.interceptors.request.use((config: AxiosRequestConfig) => {
  const transactionId = Math.random().toString(36).substring(2, 9);

  config.headers!['X-Transaction-ID'] = transactionId;
  config.headers!.Authorization = `Bearer ${getToken()}`;
  return config;
});

instance.interceptors.response.use(
  async function (config) {
    return config;
  },
  error => {
    if (error.response?.status === 401 && !error.response.data.message.includes('MemberInvitation')) {
      router.push('/');
    }
    return Promise.reject(error);
  }
);

export default instance;
