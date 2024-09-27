import {useCallback, useRef} from 'react';

export const useStableCallback = <Args extends any[], Ret>(
  callback: (...a: Args) => Ret,
): ((...a: Args) => Ret) => {
  const cb = useRef(callback);
  cb.current = callback;
  return useCallback((...args: Args) => cb.current(...args), [cb]);
};
