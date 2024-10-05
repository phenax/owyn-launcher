import React, {Suspense} from 'react';
import {SafeAreaView, View} from 'react-native';
import {GestureHandlerRootView} from 'react-native-gesture-handler';
import {AppView} from './src/AppView';
import {Provider as JotaiProvider} from 'jotai';

const App: React.FC = () => {
  return (
    <Suspense fallback={<View className="flex flex-1 bg-black" />}>
      <JotaiProvider>
        <GestureHandlerRootView>
          <SafeAreaView className="flex flex-1 bg-black text-slate-200">
            <AppView key="view" />
          </SafeAreaView>
        </GestureHandlerRootView>
      </JotaiProvider>
    </Suspense>
  );
};

export default App;
