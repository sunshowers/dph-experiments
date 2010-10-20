{-# LANGUAGE PArr #-}
{-# OPTIONS -fvectorise #-}
module DotPVect where
import Data.Array.Parallel.Prelude
import Data.Array.Parallel.PArray as P
import Data.Array.Parallel.Prelude.Int as I

dotp_internal :: [:Int:] -> [:Int:] -> Int
dotp_internal v w = I.sumP [: (I.*) x y | x <- v, y <- w :]

dotp :: PArray Int -> PArray Int -> Int
{-# NOINLINE dotp #-}
dotp v w = dotp_internal (fromPArrayP v) (fromPArrayP w)

{-# NOINLINE dotp_2level #-}
dotp_2level v1 v2 w1 w2 =
  dotp_internal vsum wsum
  where
    vsum = [: (I.+) x y | x <- (fromPArrayP v1), y <- (fromPArrayP v2) :]
    wsum = [: (I.+) x y | x <- (fromPArrayP w1), y <- (fromPArrayP w2) :]
