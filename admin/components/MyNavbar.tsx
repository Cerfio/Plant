import React from 'react';
import Image from 'next/image';
import { Navbar, Button, Text, Input } from '@nextui-org/react';

import PlantLogo from '../assets/logos/plant-logo.svg';
import SearchIcon from '../assets/icons/search.svg';
import UserIcon from '../assets/icons/user.svg';

interface Props {
  hasSearchBar?: boolean;
  hasUserIcon?: boolean;
}

const MyNavbar = ({ hasSearchBar = true, hasUserIcon = true }: Props) => {
  return (
    <Navbar variant="floating">
      <Navbar.Brand>
        <Image src={PlantLogo} alt="logo" width={50} height={50} />
        <Text b color="inherit" hideIn="xs">
          Plant Admin
        </Text>
      </Navbar.Brand>
      {hasSearchBar && (
        <Navbar.Content>
          <Navbar.Item>
            <Input
              width="400px"
              contentLeft={<Image src={SearchIcon} alt="search-icon" width={20} height={20} />}
              placeholder="Search "
            />
          </Navbar.Item>
        </Navbar.Content>
      )}
      {hasUserIcon && (
        <Navbar.Content>
          <Navbar.Item>
            <Button
              auto
              icon={<Image src={UserIcon} alt="user-icon" width={20} height={20} />}
            />
          </Navbar.Item>
        </Navbar.Content>
      )}
    </Navbar>
  );
};

export default React.memo(MyNavbar);
