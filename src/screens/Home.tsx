import React, {useMemo} from 'react';
import {Text, View} from 'react-native';
import {Clock} from '../components/Clock';

export const Home: React.FC = () => {
  return (
    <View>
      <Clock />
      <View className="p-6">
        <Text>Favorites list</Text>
      </View>
    </View>
  );
};
