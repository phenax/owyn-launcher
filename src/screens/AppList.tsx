import {matchSorter} from 'match-sorter';
import React, {useEffect, useMemo, useRef, useState} from 'react';
import {ScrollView, Text, TextInput, View} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import Icon from 'react-native-vector-icons/MaterialIcons';
import {AppMenu} from '../components/AppMenu';

export const AppList: React.FC<{apps: AppDetail[]; active: boolean}> = ({
  apps,
  active,
}) => {
  const textInputRef = useRef<TextInput>(null);
  const [searchText, setSearchText] = useState('');

  const filteredApps = useMemo(() => {
    if (searchText === '') return apps;

    return matchSorter(apps, searchText, {keys: ['label', 'packageName']});
  }, [apps, searchText]);

  // Autofocus
  useEffect(() => {
    if (!textInputRef.current) return;
    if (active) TextInput.State.focusTextInput(textInputRef.current);
  }, [active]);

  return (
    <View>
      <View className="flex justify-between flex-row items-center gap-2">
        <Icon name="search" size={21} color="#aaa" />
        <TextInput
          ref={textInputRef}
          autoFocus={false}
          autoCorrect={false}
          value={searchText}
          className="flex-1"
          onChangeText={setSearchText}
        />
      </View>

      <ScrollView contentInsetAdjustmentBehavior="automatic">
        <View className="flex-1">
          {filteredApps.map((app, index) => (
            <AppMenu app={app} key={app.packageName + index}>
              <View className="mt-4 px-4">
                <Text className="text-md font-bold dark:text-white">
                  {app.label}
                </Text>
                <Text className="text-xs">{app.packageName}</Text>
              </View>
            </AppMenu>
          ))}
        </View>
      </ScrollView>
    </View>
  );
};
