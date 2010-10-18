{-# OPTIONS -fdph-par -Odph #-}
{-# LANGUAGE PArr, ParallelListComp, CPP #-}

#ifdef PRIM
import DotPPrim
import Data.Array.Parallel.Unlifted as U
#else
import DotPVect
#endif

main = print $ dotp (makearr a1 a2) (makearr b1 b2)
  where
    a1 = dotp 
