import React, {useState} from 'react';
import {SafeAreaView} from 'react-native';
import {InstalledApps} from 'react-native-launcher-kit';
import Swiper from 'react-native-swiper';
import {AppList} from './src/screens/AppList';
import {Home} from './src/screens/Home';
import {GestureHandlerRootView} from 'react-native-gesture-handler';

function App(): React.JSX.Element {
  const [apps, setApps] = useState(() => InstalledApps.getSortedApps());
  const refreshApps = () => setApps(InstalledApps.getSortedApps());
  const [screenIndex, setScreenIndex] = useState(0);

  return (
    <GestureHandlerRootView>
      <SafeAreaView className="flex flex-1 bg-slate-100 dark:bg-black">
        <Swiper
          autoplay={false}
          horizontal
          loop={false}
          loadMinimal
          dot={<></>}
          activeDot={<></>}
          index={screenIndex}
          onIndexChanged={setScreenIndex}>
          <Home apps={apps} />

          <AppList apps={apps} screenIndex={screenIndex} />
        </Swiper>
      </SafeAreaView>
    </GestureHandlerRootView>
  );
}

export default App;
