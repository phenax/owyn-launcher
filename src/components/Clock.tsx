import React, {useEffect, useMemo, useState} from 'react';
import {Pressable, Text, View} from 'react-native';
// @ts-expect-error No declaration file
import IntentLauncher from '@angelkrak/react-native-intent-launcher';
import {useStableCallback} from '../hooks/useStableCallback';

export const Clock: React.FC = React.memo(() => {
  const [date, setDate] = useState(() => new Date());
  useEffect(() => {
    const interval = setInterval(() => {
      setDate(new Date());
    }, 5000);
    return () => clearInterval(interval);
  }, []);

  const timeText = useMemo(() => {
    const formatter = new Intl.DateTimeFormat('en', {
      hour: 'numeric',
      minute: 'numeric',
      // second: 'numeric',
    });
    return formatter.format(date);
  }, [date]);

  const dateText = useMemo(() => {
    const formatter = new Intl.DateTimeFormat('en-IN', {
      month: 'short',
      day: 'numeric',
      weekday: 'long',
    });
    return formatter.format(date);
  }, [date]);

  const showAlarms = useStableCallback(() =>
    IntentLauncher.startActivity({
      action: 'android.intent.action.SHOW_ALARMS',
    }),
  );

  return (
    <View className="p-6">
      <Pressable onPress={showAlarms} className="self-start">
        <Text className="text-4xl font-bold">{timeText}</Text>
        <Text className="text-lg">{dateText}</Text>
      </Pressable>
    </View>
  );
});
