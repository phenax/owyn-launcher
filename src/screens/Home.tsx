import React from 'react';
import {View} from 'react-native';
import {Clock} from '../components/Clock';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {Favorites} from '../components/Favorites';

export const Home: React.FC<{apps: AppDetail[]; active: boolean}> = ({
  apps,
  active,
}) => {
  return (
    <View>
      <Clock />
      <Favorites apps={apps} active={active} />
    </View>
  );
};
