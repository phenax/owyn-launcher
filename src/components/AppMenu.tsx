import {Text, View, Modal, TouchableOpacity, Pressable} from 'react-native';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useFavorites} from '../hooks/useFavorites';
import React, {useState} from 'react';
import IntentLauncher from '@angelkrak/react-native-intent-launcher';

export const AppMenu: React.FC<React.PropsWithChildren<{app: AppDetail}>> = ({
  app,
  children,
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const {addToFavorites, isFavorite, removeFromFavorites} = useFavorites();

  const menuPress = (fn: () => Promise<void> | void) => async () => {
    await fn();
    setIsOpen(false);
  };

  const menuItems = [
    isFavorite(app.packageName)
      ? {
          label: 'Remove from favorites',
          onPress: menuPress(() => removeFromFavorites(app.packageName)),
        }
      : {
          label: 'Add to favorites',
          onPress: menuPress(() => addToFavorites(app.packageName)),
        },
    {
      label: 'App info',
      onPress: menuPress(() =>
        IntentLauncher.startActivity({
          action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
          data: 'package:' + app.packageName,
        }),
      ),
    },
    {
      label: 'Uninstall',
      onPress: menuPress(() =>
        IntentLauncher.startActivity({
          action: 'android.intent.action.DELETE',
          data: 'package:' + app.packageName,
        }),
      ),
    },
  ];

  return (
    <>
      <TouchableOpacity onLongPress={() => setIsOpen(true)}>
        {children}
      </TouchableOpacity>

      <Modal
        visible={isOpen}
        transparent={true}
        animationType="none"
        onRequestClose={() => setIsOpen(false)}>
        <TouchableOpacity className="flex-1" onPress={() => setIsOpen(false)}>
          <View className="flex justify-center items-center h-full">
            <View className="shadow-lg bg-gray-900 w-2/3">
              {menuItems.map((menuItem) => (
                <Pressable
                  key={menuItem.label}
                  onPress={menuItem.onPress}
                  className="py-3 px-4 border-b border-gray-800 last:border-b-0">
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
