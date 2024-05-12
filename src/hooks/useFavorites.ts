import {useCallback, useEffect, useState} from 'react';
import {useAsyncStorage} from '@react-native-async-storage/async-storage';

export const useFavorites = () => {
  const favoritesStorage = useAsyncStorage('favorites');
  const [favoriteAppNames, setFavoriteAppNames] = useState<string[]>([]);

  const getFavoriteAppNames = useCallback(async (): Promise<string[]> => {
    try {
      const result = await favoritesStorage.getItem();
      const apps = result ? JSON.parse(result) : [];
      if (!Array.isArray(apps)) return [];
      return apps;
    } catch (err) {
      console.error(err);
      return [];
    }
  }, [favoritesStorage]);

  const refreshFavorites = useCallback(async () => {
    getFavoriteAppNames().then(setFavoriteAppNames);
  }, [getFavoriteAppNames]);

  const setFavorites = useCallback(
    async (names: string[]) => {
      const newNames = [...new Set(names)];
      setFavoriteAppNames(newNames);
      await favoritesStorage.setItem(JSON.stringify(newNames));
    },
    [favoritesStorage],
  );

  const addToFavorites = useCallback(
    async (packageName: string) => {
      const names = await getFavoriteAppNames();
      setFavorites([...names, packageName]);
    },
    [getFavoriteAppNames, setFavorites],
  );

  useEffect(() => {
    refreshFavorites();
  }, [refreshFavorites]);

  return {
    favoriteAppNames,
    getFavoriteAppNames,
    addToFavorites,
    refreshFavorites,
    setFavorites,
  };
};
