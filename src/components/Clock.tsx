import React, {useEffect, useMemo, useState} from 'react';
import {Text, View} from 'react-native';

export const Clock: React.FC = () => {
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
      second: 'numeric',
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

  return (
    <View className="p-6">
      <Text className="text-3xl font-bold">{timeText}</Text>
      <Text className="text-lg">{dateText}</Text>
    </View>
  );
};
