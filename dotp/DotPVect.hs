{-# LANGUAGE PArr #-}
{-# OPTIONS -fvectorise #-}
module DotPVect where
import Data.Array.Parallel.Prelude
import Data.Array.Parallel.Prelude.Int as I

dotp :: [:Int:] -> [:Int:] -> Int
dotp v w = I.sumP [: (I.*) x y | x <- v, y <- w :]
