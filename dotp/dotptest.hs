{-# OPTIONS -fdph-par -Odph #-}
{-# LANGUAGE PArr, ParallelListComp, CPP #-}

#ifdef UNLIFTED
import DotPPrim
import Data.Array.Parallel.Unlifted as U
#else
import DotPVect
#endif

main = print $ dotp (makearr a1 a2) (makearr b1 b2)
  where
    a1 = dotp (makearr 1 20) (makearr 21 40)
    a2 = dotp (makearr 41 60) (makearr 61 80)
    b1 = dotp (makearr 81 100) (makearr 101 120)
    b2 = dotp (makearr 121 140) (makearr 141 160)

#ifdef UNLIFTED
makearr n m = U.enumFromTo n m
#else
makearr n m = [:n..m:]
#endif
