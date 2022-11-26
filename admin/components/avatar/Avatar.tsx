import React from 'react';

import styles from './Avatar.module.scss';

interface Props {
  firstName: string;
  lastName: string;
}

const Avatar = ({ firstName, lastName }: Props) => {
  return (
    <div className={styles.avatar}>
      <p className={styles.avatar__text}>
        {firstName.charAt(0).toUpperCase()}
        {lastName.charAt(0).toUpperCase()}
      </p>
    </div>
  );
};

export default React.memo(Avatar);
