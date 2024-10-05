import {
  Text,
  View,
  Modal,
  TouchableOpacity,
  Pressable,
  TouchableNativeFeedback,
} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useFavorites} from '../hooks/useFavorites';
import React, {useState} from 'react';
// @ts-expect-error No declaration file
import IntentLauncher from '@angelkrak/react-native-intent-launcher';
import {useStableCallback} from '../hooks/useStableCallback';

export const AppMenu: React.FC<React.PropsWithChildren<{app: AppDetail}>> = ({
  app,
  children,
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const {addToFavorites, isFavorite, removeFromFavorites} = useFavorites();

  const openContextMenu = useStableCallback(() => setIsOpen(true));
  const closeContextMenu = useStableCallback(() => setIsOpen(false));

  const onMenuItemPress = (fn: () => Promise<void> | void) => async () => {
    closeContextMenu();
    await fn();
  };
  const menuItems = [
    isFavorite(app.packageName)
      ? {
          label: 'Remove from favorites',
          onPress: onMenuItemPress(() => removeFromFavorites(app.packageName)),
        }
      : {
          label: 'Add to favorites',
          onPress: onMenuItemPress(() => addToFavorites(app.packageName)),
        },
    {
      label: 'App info',
      onPress: onMenuItemPress(() =>
        IntentLauncher.startActivity({
          action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
          data: 'package:' + app.packageName,
        }),
      ),
    },
    {
      label: 'Uninstall',
      onPress: onMenuItemPress(() =>
        IntentLauncher.startActivity({
          action: 'android.intent.action.DELETE',
          data: 'package:' + app.packageName,
        }),
      ),
    },
  ];

  const openApp = useStableCallback(() =>
    IntentLauncher.startAppByPackageName(app.packageName),
  );

  return (
    <>
      <TouchableNativeFeedback
        onPress={openApp}
        onLongPress={openContextMenu}
        delayPressIn={100}>
        {children}
      </TouchableNativeFeedback>

      <Modal
        visible={isOpen}
        transparent={true}
        animationType="none"
        onRequestClose={closeContextMenu}>
        <TouchableOpacity className="flex-1" onPress={closeContextMenu}>
          <View className="flex justify-center items-center h-full">
            <View className="bg-[#181818] border border-[#222] w-2/3">
              <Text className="text-slate-500 text-xs text-center border-b border-slate-500">
                {app.label}
              </Text>

              {menuItems.map((menuItem) => (
                <Pressable
                  key={menuItem.label}
                  onPress={menuItem.onPress}
                  className="py-3 px-4 border-b border-[#222] last:border-b-0 last:border-transparent">
                  <Text className="text-lg text-gray-300">
                    {menuItem.label}
                  </Text>
                </Pressable>
              ))}
            </View>
          </View>
        </TouchableOpacity>
      </Modal>
    </>
  );
};
