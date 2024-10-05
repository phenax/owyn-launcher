import React, {Suspense, useEffect} from 'react';
import {BackHandler, SafeAreaView, View} from 'react-native';
import {GestureHandlerRootView} from 'react-native-gesture-handler';
import {AppView} from './src/AppView';
import {Provider as JotaiProvider} from 'jotai';

const App: React.FC = () => {
  // Disable back button
  useEffect(() => {
    const sub = BackHandler.addEventListener('hardwareBackPress', () => true);
    return () => sub.remove();
  }, []);

  return (
    <Suspense fallback={<View className="flex flex-1 bg-black" />}>
      <JotaiProvider>
        <GestureHandlerRootView>
          <SafeAreaView className="flex flex-1 bg-black text-slate-200">
            <AppView />
          </SafeAreaView>
        </GestureHandlerRootView>
      </JotaiProvider>
    </Suspense>
  );
};

export default App;
