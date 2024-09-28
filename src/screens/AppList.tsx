import {matchSorter} from 'match-sorter';
import React, {useEffect, useMemo, useRef, useState} from 'react';
import {
  ScrollView,
  Text,
  TextInput,
  TouchableHighlight,
  View,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import {AppMenu} from '../components/AppMenu';
import {useInstalledApps} from '../hooks/useInstalledApps';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useStableCallback} from '../hooks/useStableCallback';

const AppListItem: React.FC<{app: AppDetail}> = React.memo(({app}) => {
  return (
    <AppMenu app={app}>
      <View className="p-2">
        <Text className="text-md font-bold">{app.label}</Text>
        <Text className="text-xs text-gray-600">{app.packageName}</Text>
      </View>
    </AppMenu>
  );
});

export const AppList: React.FC<{active: boolean}> = React.memo(({active}) => {
  const {apps} = useInstalledApps();
  const textInputRef = useRef<TextInput>(null);
  const [searchText, setSearchText] = useState('');

  const clearSearchInput = useStableCallback(() => setSearchText(''));

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
    <View className="px-2">
      <View className="flex justify-between flex-row items-center gap-2 px-2">
        <Icon name="search" size={21} color="#555" className="py-2" />
        <TextInput
          ref={textInputRef}
          autoFocus={false}
          autoCorrect={false}
          value={searchText}
          className="flex-1"
          onChangeText={setSearchText}
        />
        <TouchableHighlight
          underlayColor="#222"
          onPress={clearSearchInput}
          className="p-2">
          <Icon name="close" size={21} color="#aaa" />
        </TouchableHighlight>
      </View>

      <ScrollView contentInsetAdjustmentBehavior="automatic">
        <View className="flex-1">
          {filteredApps.map((app, index) => (
            <AppListItem app={app} key={app.packageName + index} />
          ))}
        </View>
      </ScrollView>
    </View>
  );
});
