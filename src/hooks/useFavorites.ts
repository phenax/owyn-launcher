import {useAsyncStorage} from '@react-native-async-storage/async-storage';
import {useStableCallback} from './useStableCallback';
import {atom, useAtom} from 'jotai';

const favoriteAppNamesAtom = atom<string[]>([]);

const serialize = (packageNames: string[]) => JSON.stringify(packageNames);

const deserialize = (packageNames: string): string[] => {
  try {
    const apps = JSON.parse(packageNames);
    if (!Array.isArray(apps)) return [];
    return apps;
  } catch (err) {
    console.error(err);
    return [];
  }
};

export const useFavorites = () => {
  const favoritesStorage = useAsyncStorage('favorites');
  const [favoriteAppNames, setFavoriteAppNames] = useAtom(favoriteAppNamesAtom);

  const getFavoriteAppNames = useStableCallback(async (): Promise<string[]> => {
    const result = await favoritesStorage.getItem();
    return deserialize(result ?? 'null');
  });

  const setFavoritesState = useStableCallback((packageNames: string[]) => {
    const newNames = [...new Set(packageNames)];
    if (serialize(newNames) === serialize(favoriteAppNames)) return newNames;

    setFavoriteAppNames(newNames);
    return newNames;
  });

  const setFavorites = useStableCallback(async (packageNames: string[]) => {
    const newNames = setFavoritesState(packageNames);
    await favoritesStorage.setItem(serialize(newNames));
  });

  const refreshFavorites = useStableCallback(async () => {
    getFavoriteAppNames().then(setFavoritesState);
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
