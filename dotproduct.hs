{-# OPTIONS -fdph-par -Odph #-}
{-# LANGUAGE PArr, ParallelListComp #-}
import Data.Array.Parallel.Unlifted as U
import DotPPrim

aPar = U.enumFromTo 1 800000

bPar = U.enumFromTo 800001 1600000

main = print (dotp aPar bPar);
