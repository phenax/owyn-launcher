import React, {useEffect, useState} from 'react';
import Swiper from 'react-native-swiper';
import {AppList} from './screens/AppList';
import {Home} from './screens/Home';
import {useInstalledApps} from './hooks/useInstalledApps';
import {BackHandler} from 'react-native';

const screens = [
  {id: 'home', component: Home},
  {id: 'appList', component: AppList},
];

export const AppView: React.FC = React.memo(() => {
  const {refreshApps} = useInstalledApps();
  const [screenIndex, setScreenIndex] = useState(0);

  // Refresh app list when switching between screens
  useEffect(() => {
    refreshApps();
  }, [screenIndex, refreshApps]);

  // Disable back button
  useEffect(() => {
    const sub = BackHandler.addEventListener('hardwareBackPress', () => {
      return true;
    });
    return () => sub.remove();
  }, []);

  return (
    <Swiper
      horizontal
      autoplay={false}
      loop={false}
      dot={<></>}
      activeDot={<></>}
      onIndexChanged={setScreenIndex}>
      {screens.map(({id, component: Screen}, i) => (
        <Screen key={id} active={screenIndex === i} />
      ))}
    </Swiper>
  );
});
