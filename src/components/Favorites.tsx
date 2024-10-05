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
import {AppMenu} from './AppMenu';
import {useInstalledApps} from '../hooks/useInstalledApps';

const AppLabel: React.FC<{app: AppDetail}> = React.memo(({app}) => {
  return (
    <View className="flex-1">
      <AppMenu app={app}>
        <View className="py-3 px-2">
          <Text className="text-lg">{app.label}</Text>
        </View>
      </AppMenu>
    </View>
  );
});

export const Favorites: React.FC<{active: boolean}> = (_) => {
  const {apps} = useInstalledApps();
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
      setFavorites(() => data.map((app) => app.packageName));
    },
    [setFavorites],
  );

  return (
    <View className="px-4 py-1">
      <DraggableFlatList
        data={favoriteApps}
        onDragEnd={onDragEnd}
        keyExtractor={(app) => app.packageName}
        activationDistance={10}
        scrollEnabled
        renderPlaceholder={() => <View className="flex-1 bg-[#141414]" />}
        renderItem={({item: app, drag, isActive}) => (
          <ShadowDecorator key={app.packageName}>
            <OpacityDecorator>
              <View
                className={`flex-row justify-stretch items-center ${
                  isActive ? 'bg-[#181818] opacity-60' : ''
                }`}>
                <TouchableOpacity
                  onLongPress={drag}
                  disabled={isActive}
                  hitSlop={10}
                  className="pr-2 py-3">
                  <Icon name="drag-indicator" size={21} color="#333" />
                </TouchableOpacity>

                <AppLabel app={app} />
              </View>
            </OpacityDecorator>
          </ShadowDecorator>
        )}
      />
    </View>
  );
};
