import {matchSorter} from 'match-sorter';
import React, {useMemo, useState} from 'react';
import {ScrollView, Text, TextInput, View} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';

export const AppList: React.FC<{apps: AppDetail[]}> = ({apps}) => {
  const [searchText, setSearchText] = useState('');

  const filteredApps = useMemo(() => {
    if (searchText === '') return apps;

    return matchSorter(apps, searchText, {keys: ['label', 'packageName']});
  }, [apps, searchText]);

  return (
    <View>
      <View>
        <TextInput
          autoFocus
          autoCorrect={false}
          value={searchText}
          onChangeText={setSearchText}
        />
      </View>

      <ScrollView contentInsetAdjustmentBehavior="automatic">
        <View className="flex-1">
          {filteredApps.map((app, index) => (
            <View className="mt-4 px-4" key={app.packageName + index}>
              <Text className="text-md font-bold dark:text-white">
                {app.label}
              </Text>
              <Text className="text-xs">{app.packageName}</Text>
            </View>
          ))}
        </View>
      </ScrollView>
    </View>
  );
};
