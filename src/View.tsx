import React, {useEffect, useState} from 'react';
import Swiper from 'react-native-swiper';
import {AppList} from './screens/AppList';
import {Home} from './screens/Home';
import {useInstalledApps} from './hooks/useInstalledApps';
import {useFavorites} from './hooks/useFavorites';

export const View: React.FC = React.memo(() => {
  const {refreshApps} = useInstalledApps();
  const {refreshFavorites} = useFavorites();
  const [screenIndex, setScreenIndex] = useState(0);

  useEffect(() => {
    refreshApps();
    refreshFavorites();
  }, [screenIndex, refreshApps, refreshFavorites]);

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
