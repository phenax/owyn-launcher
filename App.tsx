import React, {useState} from 'react';
import {SafeAreaView, Text, View} from 'react-native';
import {InstalledApps} from 'react-native-launcher-kit';
import Swiper from 'react-native-swiper';
import {AppList} from './src/screens/AppList';

function App(): React.JSX.Element {
  const [apps, _setApps] = useState(() => InstalledApps.getSortedApps());

  return (
    <SafeAreaView className="flex flex-1 bg-slate-100 dark:bg-black">
      <Swiper
        autoplay={false}
        horizontal
        loop={false}
        loadMinimal
        dot={<></>}
        activeDot={<></>}>
        <View>
          <Text>Wow</Text>
        </View>

        <AppList apps={apps} />
      </Swiper>
    </SafeAreaView>
  );
}

export default App;
