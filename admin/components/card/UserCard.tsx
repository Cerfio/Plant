import React from 'react';
import { Card, Text, Row } from '@nextui-org/react';
import MyAvatar from '../avatar/Avatar';

interface Props {
  firstName: string;
  lastName: string;
  isAdmin?: boolean;
}

const UserCard = ({ firstName, lastName, isAdmin }: Props) => {
  return (
    <Card isPressable isHoverable>
      <Card.Body css={{ p: 0 }}>
        <MyAvatar firstName={firstName} lastName={lastName} />
      </Card.Body>
      <Card.Footer css={{ justifyItems: 'flex-start' }}>
        <Row wrap="wrap" justify="space-between" align="center">
          <Text b>
            {firstName} {lastName}
          </Text>
          <Text css={{ color: '$accents7', fontWeight: '$semibold', fontSize: '$sm' }}>
            {isAdmin ? 'Admin' : 'User'}
          </Text>
        </Row>
      </Card.Footer>
    </Card>
  );
};

export default React.memo(UserCard);
