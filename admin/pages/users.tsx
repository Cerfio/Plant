import React from 'react';

import { useQuery } from '@tanstack/react-query';
import { Grid, Text, Spacer, Loading } from '@nextui-org/react';

import { getUsers } from '../services/users';
import MyNavbar from '../components/MyNavbar';
import UserCard from '../components/card/UserCard';

import styles from '../styles/Users.module.scss';

const Users = () => {
  const { isLoading, data } = getUsers();

  return (
    <div className={styles.users}>
      <MyNavbar />
      <main className={styles.users__main}>
        <Text
          h1
          css={{
            textGradient: '45deg, $blue600 -20%, $pink600 50%'
          }}
          weight="bold">
          List of users
        </Text>
        <Spacer y={2} />
        {isLoading ? (
          <Loading size="xl" />
        ) : (
          <Grid.Container gap={2} justify="center">
            {data?.map(user => (
              <Grid xs={6} sm={2}>
                <UserCard firstName={user.firstname} lastName={user.lastname} isAdmin={user.admin} />
              </Grid>
            ))}
          </Grid.Container>
        )}
      </main>
    </div>
  );
};

export default Users;
