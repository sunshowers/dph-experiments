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
    v1 = (makearr 1 100)
    v2 = (makearr 101 200)
    w1 = (makearr 201 300)
    w2 = (makearr 301 400)

makearr n m = P.enumFromTo n m
