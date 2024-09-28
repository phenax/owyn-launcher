import React from 'react';
import {SafeAreaView} from 'react-native';
import {GestureHandlerRootView} from 'react-native-gesture-handler';
import {View} from './src/View';

const App: React.FC = () => {
  return (
    <GestureHandlerRootView>
      <SafeAreaView className="flex flex-1 bg-black">
        <View />
      </SafeAreaView>
    </GestureHandlerRootView>
  );
};

export default App;
