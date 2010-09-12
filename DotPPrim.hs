module DotPPrim where

import Data.Array.Parallel.Unlifted as U

dotp :: U.Array Int -> U.Array Int -> Int
{-# NOINLINE dotp #-}
dotp v w = U.sum (U.zipWith (*) v w)

