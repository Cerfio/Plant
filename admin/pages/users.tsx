import React from 'react';

import { useQuery } from '@tanstack/react-query';
import { Card, Button, Text, Spacer, Row, Input, Avatar } from '@nextui-org/react';

import MyNavbar from '../components/MyNavbar';

import styles from '../styles/Users.module.scss';

const Users = () => {
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
        <div className={styles.users__main__cards}>
          <Card isPressable isHoverable css={{ mw: '300px' }}>
            {/* <Avatar squared text="Jane" />
              <Spacer x={1} />
              <Text h3>Jane Doe</Text> */}
            <Card.Body css={{ p: 0 }}>
              
              {/* <Card.Image
                src={'https://nextui.org' + '/images/fruit-1.jpeg'}
                objectFit="cover"
                width="100%"
                height={140}
                alt={'Fruit'}
              /> */}
            </Card.Body>
            <Card.Footer css={{ justifyItems: 'flex-start' }}>
              <Row wrap="wrap" justify="space-between" align="center">
                <Text b>{'Fruit'}</Text>
                <Text css={{ color: '$accents7', fontWeight: '$semibold', fontSize: '$sm' }}>{'Normal'}</Text>
              </Row>
            </Card.Footer>
          </Card>
        </div>
      </main>
    </div>
  );
};

export default Users;
