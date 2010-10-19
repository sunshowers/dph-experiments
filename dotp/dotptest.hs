{-# LANGUAGE PArr, CPP #-}

#ifdef UNLIFTED
import DotPPrim
import Data.Array.Parallel.Unlifted as P
#else
import DotPVect
import Data.Array.Parallel.PArray as P
#endif

main = print $ dotp_2level v1 v2 w1 w2
  where
    v1 = (makearr 1 40)
    v2 = (makearr 41 80)
    w1 = (makearr 81 120)
    w2 = (makearr 121 160)

makearr n m = P.enumFromTo n m
