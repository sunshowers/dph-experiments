{-# LANGUAGE PArr, CPP #-}

#ifdef UNLIFTED
import DotPPrim
import Data.Array.Parallel.Unlifted as U
#else
import DotPVect
#endif

main = print $ dotp (makearr 1 40) (makearr 41 80)

#ifdef UNLIFTED
makearr n m = U.enumFromTo n m
#else
makearr n m = [:n..m:]
#endif
