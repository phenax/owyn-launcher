import {matchSorter} from 'match-sorter';
import React, {useEffect, useMemo, useRef, useState} from 'react';
import {ScrollView, Text, TextInput, View} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useFavorites} from '../hooks/useFavorites';
import {TouchableOpacity} from 'react-native-gesture-handler';
import Icon from 'react-native-vector-icons/MaterialIcons';

export const AppList: React.FC<{apps: AppDetail[]; isActive: boolean}> = ({
  apps,
  isActive,
}) => {
  const {addToFavorites} = useFavorites();

  const textInputRef = useRef<TextInput>(null);
  const [searchText, setSearchText] = useState('');

  const filteredApps = useMemo(() => {
    if (searchText === '') return apps;

    return matchSorter(apps, searchText, {keys: ['label', 'packageName']});
  }, [apps, searchText]);

  // Autofocus
  useEffect(() => {
    if (!textInputRef.current) return;
    if (isActive) TextInput.State.focusTextInput(textInputRef.current);
  }, [isActive]);

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
            <View className="mt-4 px-4" key={app.packageName + index}>
              <TouchableOpacity
                onLongPress={() => addToFavorites(app.packageName)}>
                <Text className="text-md font-bold dark:text-white">
                  {app.label}
                </Text>
                <Text className="text-xs">{app.packageName}</Text>
              </TouchableOpacity>
            </View>
          ))}
        </View>
      </ScrollView>
    </View>
  );
};
