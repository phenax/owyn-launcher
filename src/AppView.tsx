import React, {useEffect, useState} from 'react';
import Swiper from 'react-native-swiper';
import {AppList} from './screens/AppList';
import {Home} from './screens/Home';
import {useInstalledApps} from './hooks/useInstalledApps';

export const AppView: React.FC = React.memo(() => {
  const {refreshApps} = useInstalledApps();
  const [screenIndex, setScreenIndex] = useState(0);

  useEffect(() => {
    refreshApps();
  }, [screenIndex, refreshApps]);

  return (
    <Swiper
      horizontal
      autoplay={false}
      loop={false}
      dot={<></>}
      activeDot={<></>}
      onIndexChanged={setScreenIndex}>
      <Home active={screenIndex === 0} />
      <AppList active={screenIndex === 1} />
    </Swiper>
  );
});
