import React, {useCallback, useMemo} from 'react';
import {ScrollView, Text, TouchableOpacity, View} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useFavorites} from '../hooks/useFavorites';
import DraggableFlatList, {
  OpacityDecorator,
  ScaleDecorator,
  ShadowDecorator,
} from 'react-native-draggable-flatlist';
import Icon from 'react-native-vector-icons/MaterialIcons';

export const Favorites: React.FC<{apps: AppDetail[]}> = ({apps}) => {
  const {favoriteAppNames, setFavorites} = useFavorites();

  const appByName = useMemo(
    () => Object.fromEntries(apps.map(app => [app.packageName, app])),
    [apps],
  );

  const favoriteApps = useMemo(
    () => favoriteAppNames.map(name => appByName[name]).filter(Boolean),
    [appByName, favoriteAppNames],
  );

  const onDragEnd = useCallback(
    ({data}: {data: AppDetail[]}) => {
      setFavorites(data.map(app => app.packageName));
    },
    [setFavorites],
  );

  return (
    <View>
      <DraggableFlatList
        data={favoriteApps}
        onDragEnd={onDragEnd}
        keyExtractor={item => item.packageName}
        renderItem={({item: app, drag, isActive}) => (
          <ShadowDecorator>
            <ScaleDecorator>
              <OpacityDecorator>
                <View
                  className={`py-4 px-2 flex-row ${
                    isActive ? 'bg-gray-700 opacity-60' : ''
                  }`}>
                  <TouchableOpacity
                    onLongPress={drag}
                    disabled={isActive}
                    delayLongPress={500}>
                    <View className={'py-1 pl-3 pr-3'}>
                      <Icon name="drag-indicator" size={21} color="#666" />
                    </View>
                  </TouchableOpacity>

                  <Text className="text-lg">{app.label}</Text>
                </View>
              </OpacityDecorator>
            </ScaleDecorator>
          </ShadowDecorator>
        )}
        renderPlaceholder={() => <View className="flex-1 bg-gray-700" />}
      />
    </View>
  );
};
