{-# LANGUAGE PArr, CPP #-}

#ifdef UNLIFTED
import DotPPrim
import Data.Array.Parallel.Unlifted as P
#else
import DotPVect
import Data.Array.Parallel.PArray as P
#endif

main = print $ dotp (makearr a1 (a1 + 40)) (makearr a1 (a1 + 40))
  where
    a1 = dotp (makearr 1 20) (makearr 21 40)

makearr n m = P.enumFromTo n m
