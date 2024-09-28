import React, {useState} from 'react';
import {InstalledApps} from 'react-native-launcher-kit';
import Swiper from 'react-native-swiper';
import {AppList} from './screens/AppList';
import {Home} from './screens/Home';

export const View: React.FC = () => {
  const [apps, _setApps] = useState(() => InstalledApps.getSortedApps());
  const [screenIndex, setScreenIndex] = useState(0);

  // const refreshApps = () => setApps(InstalledApps.getSortedApps());

  // useEffect(() => {
  //   refreshApps();
  // }, [screenIndex]);

  return (
    <Swiper
      horizontal
      autoplay={false}
      loop={false}
      dot={<></>}
      activeDot={<></>}
      onIndexChanged={setScreenIndex}>
      <Home apps={apps} active={screenIndex === 0} />
      <AppList apps={apps} active={screenIndex === 1} />
    </Swiper>
  );
};
