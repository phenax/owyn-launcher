import React, {useState} from 'react';
import {SafeAreaView} from 'react-native';
import {InstalledApps} from 'react-native-launcher-kit';
import Swiper from 'react-native-swiper';
import {AppList} from './src/screens/AppList';
import {Home} from './src/screens/Home';
import {GestureHandlerRootView} from 'react-native-gesture-handler';

const App: React.FC = () => {
  const [apps, _setApps] = useState(() => InstalledApps.getSortedApps());
  const [screenIndex, setScreenIndex] = useState(0);

  // const refreshApps = () => setApps(InstalledApps.getSortedApps());

  // useEffect(() => {
  //   refreshApps();
  // }, [screenIndex]);

  return (
    <GestureHandlerRootView>
      <SafeAreaView className="flex flex-1 bg-slate-100 dark:bg-black">
        <Swiper
          horizontal
          autoplay={false}
          loop={false}
          dot={<></>}
          activeDot={<></>}
          onIndexChanged={setScreenIndex}>
          <Home apps={apps} />
          <AppList apps={apps} isActive={screenIndex === 1} />
        </Swiper>
      </SafeAreaView>
    </GestureHandlerRootView>
  );
};

export default App;
