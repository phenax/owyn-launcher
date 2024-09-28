import React from 'react';
import {View} from 'react-native';
import {Clock} from '../components/Clock';
import {Favorites} from '../components/Favorites';

export const Home: React.FC<{active: boolean}> = ({active}) => {
  return (
    <View>
      <Clock />
      <Favorites active={active} />
    </View>
  );
};
