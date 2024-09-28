import {useEffect, useState} from 'react';
import {useAsyncStorage} from '@react-native-async-storage/async-storage';
import {useStableCallback} from './useStableCallback';

export const useFavorites = () => {
  const favoritesStorage = useAsyncStorage('favorites');
  const [favoriteAppNames, setFavoriteAppNames] = useState<string[]>([]);

  const getFavoriteAppNames = useStableCallback(async (): Promise<string[]> => {
    try {
      const result = await favoritesStorage.getItem();
      const apps = result ? JSON.parse(result) : [];
      if (!Array.isArray(apps)) return [];
      return apps;
    } catch (err) {
      console.error(err);
      return [];
    }
  });

  const refreshFavorites = useStableCallback(async () => {
    getFavoriteAppNames().then(setFavoriteAppNames);
  });

  const setFavorites = useStableCallback(async (names: string[]) => {
    const newNames = [...new Set(names)];
    await favoritesStorage.setItem(JSON.stringify(newNames));
    refreshFavorites();
  });

  const addToFavorites = useStableCallback(async (packageName: string) => {
    const names = await getFavoriteAppNames();
    setFavorites([...names, packageName]);
  });
  const removeFromFavorites = useStableCallback(async (packageName: string) => {
    const names = await getFavoriteAppNames();
    setFavorites(names.filter((name) => name !== packageName));
  });

  const isFavorite = useStableCallback((packageName: string) =>
    favoriteAppNames.includes(packageName),
  );

  useEffect(() => {
    refreshFavorites();
  }, [refreshFavorites]);

  return {
    addToFavorites,
    favoriteAppNames,
    getFavoriteAppNames,
    isFavorite,
    refreshFavorites,
    removeFromFavorites,
    setFavorites,
  };
};
