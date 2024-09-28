import {atom, useAtom} from 'jotai';
import {InstalledApps} from 'react-native-launcher-kit';
import {AppDetail} from 'react-native-launcher-kit/typescript/Interfaces/InstalledApps';
import {useStableCallback} from './useStableCallback';

const installedAppsAtom = atom<AppDetail[]>(InstalledApps.getSortedApps());

export const useInstalledApps = () => {
  const [apps, setApps] = useAtom(installedAppsAtom);

  const refreshApps = useStableCallback(() =>
    setApps(InstalledApps.getSortedApps()),
  );

  return {
    apps,
    refreshApps,
  };
};
