import React from 'react';
import Image from 'next/image';
import { useRouter } from 'next/router';
import { useMutation } from '@tanstack/react-query';
import { Card, Button, Text, Spacer, Row, Loading } from '@nextui-org/react';
import { Formik, Field, Form } from 'formik';

import MyNavbar from '../components/MyNavbar';

import { signIn } from '../services/auth';
import { setToken } from '../cookies/User';

import UserIcon from '../assets/icons/user.svg';
import styles from '../styles/Home.module.scss';

const Home = () => {
  const router = useRouter();

  const { isLoading, mutate } = useMutation(signIn, {
    onSuccess: data => {
      setToken(data.token);
      router.push('/users');
    }
  });

  return (
    <div className={styles.home}>
      <MyNavbar hasSearchBar={false} hasUserIcon={false} />
      <main className={styles.home__main}>
        <Text
          h1
          size={60}
          css={{
            textGradient: '45deg, $blue600 -20%, $pink600 50%'
          }}
          weight="bold">
          Welcome to Plant Admin
        </Text>

        <Formik
          initialValues={{ email: '', password: '' }}
          onSubmit={values => {
            if (values.email && values.password) {
              mutate(values);
            }
          }}>
          <Form className={styles.home__main__form}>
            <Card isHoverable css={{ mw: '400px', p: 24 }}>
              <Card.Header>
                <Image src={UserIcon} alt="user-icon" width={40} height={40} />
                <Spacer />
                <Text h3>Sign In</Text>
              </Card.Header>
              <Card.Body>
                <Field id="email" name="email" placeholder="Email" />
                <Spacer y={1} />
                <Field id="password" name="password" placeholder="Password" />
              </Card.Body>
              <Card.Footer>
                <Row wrap="wrap" justify="center" align="center">
                  <Button type="submit">
                    {isLoading ? (
                      <Loading color="currentColor" size="sm" />
                    ) : (
                      <Text h4 color="#FFFFFF">
                        Sign In
                      </Text>
                    )}
                  </Button>
                </Row>
              </Card.Footer>
            </Card>
          </Form>
        </Formik>
      </main>
    </div>
  );
};

export default Home;
