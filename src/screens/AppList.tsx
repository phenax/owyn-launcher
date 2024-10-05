import {matchSorter} from 'match-sorter';
import React, {
  ComponentProps,
  useEffect,
  useMemo,
  useRef,
  useState,
} from 'react';
import {Pressable, ScrollView, Text, TextInput, View} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import {AppMenu} from '../components/AppMenu';
import {useInstalledApps} from '../hooks/useInstalledApps';
import {useStableCallback} from '../hooks/useStableCallback';
import {TouchableHighlight} from 'react-native-gesture-handler';

const AppListItem: React.FC<ComponentProps<typeof AppMenu>> = React.memo(
  ({app, ...props}) => {
    return (
      <AppMenu app={app} {...props}>
        <View className="p-2">
          <Text className="text-base">{app.label}</Text>
          <Text className="text-xs text-gray-600">{app.packageName}</Text>
        </View>
      </AppMenu>
    );
  },
);

export const AppList: React.FC<{active: boolean}> = React.memo(({active}) => {
  const {apps} = useInstalledApps();
  const textInputRef = useRef<TextInput>(null);
  const [searchText, setSearchText] = useState('');

  const focusInput = useStableCallback(() => {
    if (active)
      TextInput.State.focusTextInput(textInputRef.current ?? undefined);
  });

  const clearSearchInput = useStableCallback(() => {
    setSearchText('');
    focusInput();
  });

  const filteredApps = useMemo(() => {
    if (searchText === '') return apps;

    return matchSorter(apps, searchText, {keys: ['label', 'packageName']});
  }, [apps, searchText]);

  // Autofocus when active
  useEffect(() => {
    active && focusInput();
  }, [active, focusInput]);

  return (
    <View className="px-2">
      <View className="flex justify-between flex-row items-center gap-2 px-2 border-b border-slate-800">
        <Pressable onPress={focusInput} accessible={false}>
          <Icon name="search" size={21} color="#666" className="py-2" />
        </Pressable>
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
          className="p-2 rounded-full">
          <Icon name="close" size={17} color="#666" />
        </TouchableHighlight>
      </View>

      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        keyboardShouldPersistTaps="always"
        keyboardDismissMode="on-drag"
        className="pt-2">
        <View className="flex-1">
          {filteredApps.map((app, index) => (
            <AppListItem app={app} key={app.packageName + index} />
          ))}
        </View>
      </ScrollView>
    </View>
  );
});
