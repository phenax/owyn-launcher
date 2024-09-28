import React from 'react';
import {SafeAreaView} from 'react-native';
import {GestureHandlerRootView} from 'react-native-gesture-handler';
import {View} from './src/View';
import {Provider as JotaiProvider} from 'jotai';

const App: React.FC = () => {
  return (
    <JotaiProvider>
      <GestureHandlerRootView>
        <SafeAreaView className="flex flex-1 bg-black text-slate-200">
          <View />
        </SafeAreaView>
      </GestureHandlerRootView>
    </JotaiProvider>
  );
};

export default App;
