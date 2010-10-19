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
    v1 = (makearr 1 20)
    v2 = (makearr 21 40)
    w1 = (makearr 41 60)
    w2 = (makearr 61 80)

makearr n m = P.enumFromTo n m
