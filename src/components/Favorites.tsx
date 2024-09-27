import React, {useCallback, useMemo} from 'react';
import {Text, TouchableOpacity, View} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useFavorites} from '../hooks/useFavorites';
import DraggableFlatList, {
  DragEndParams,
  OpacityDecorator,
  ShadowDecorator,
} from 'react-native-draggable-flatlist';
import Icon from 'react-native-vector-icons/MaterialIcons';

export const Favorites: React.FC<{apps: AppDetail[]}> = ({apps}) => {
  const {favoriteAppNames, setFavorites} = useFavorites();

  const appByName = useMemo(
    () => Object.fromEntries(apps.map((app) => [app.packageName, app])),
    [apps],
  );

  const favoriteApps = useMemo(
    () => favoriteAppNames.map((name) => appByName[name]).filter(Boolean),
    [appByName, favoriteAppNames],
  );

  const onDragEnd = useCallback(
    ({data}: DragEndParams<AppDetail>) => {
      setFavorites(data.map((app) => app.packageName));
    },
    [setFavorites],
  );

  return (
    <View className="px-4">
      <DraggableFlatList
        data={favoriteApps}
        onDragEnd={onDragEnd}
        keyExtractor={(item) => item.packageName}
        renderItem={({item: app, drag, isActive}) => (
          <ShadowDecorator>
            <OpacityDecorator>
              <View
                className={`py-2 px-2 flex-row w-full ${
                  isActive ? 'bg-gray-200 opacity-60' : ''
                }`}>
                <Text className="text-lg flex-1">{app.label}</Text>
                <TouchableOpacity
                  onLongPress={drag}
                  disabled={isActive}
                  delayLongPress={500}>
                  <View className={'py-1'}>
                    <Icon name="drag-indicator" size={21} color="#aaa" />
                  </View>
                </TouchableOpacity>
              </View>
            </OpacityDecorator>
          </ShadowDecorator>
        )}
        renderPlaceholder={() => <View className="flex-1 bg-gray-200" />}
      />
    </View>
  );
};
