import Cookies from 'universal-cookie';

const cookies = new Cookies();

export const getToken = () => cookies.get('token');
export const setToken = (token: string) => cookies.set('token', token);
export const removeToken = () => cookies.remove('token');