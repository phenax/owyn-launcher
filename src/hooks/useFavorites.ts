import AsyncStorage from '@react-native-async-storage/async-storage/src/AsyncStorage';
import {useStableCallback} from './useStableCallback';
import {useAtom} from 'jotai';
import {createJSONStorage, atomWithStorage} from 'jotai/utils';

const jsonStorage = createJSONStorage<string[]>(() => AsyncStorage);
const favoriteAppNamesAtom = atomWithStorage<string[]>(
  'favorites',
  [],
  jsonStorage,
);

const isSameArray = (a: string[], b: string[]): boolean => {
  if (a.length !== b.length) return false;
  return a.every((item, index) => item === b[index]);
};

export const useFavorites = () => {
  const [favoriteAppNames, setFavoriteAppNames] = useAtom(favoriteAppNamesAtom);

  const setFavorites = useStableCallback(
    async (
      updater: (packageNames: string[]) => Promise<string[]> | string[],
    ) => {
      const newNames = [...new Set(await updater(favoriteAppNames))];
      if (isSameArray(newNames, favoriteAppNames)) return newNames;

      setFavoriteAppNames(newNames);
      return newNames;
    },
  );

  const addToFavorites = useStableCallback(async (packageName: string) => {
    setFavorites((names) => [...names, packageName]);
  });
  const removeFromFavorites = useStableCallback(async (packageName: string) => {
    setFavorites((names) => names.filter((name) => name !== packageName));
  });

  const isFavorite = useStableCallback((packageName: string) =>
    favoriteAppNames.includes(packageName),
  );

  return {
    addToFavorites,
    favoriteAppNames,
    isFavorite,
    removeFromFavorites,
    setFavorites,
  };
};
