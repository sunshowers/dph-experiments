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

{- Given a number of integers, constructs a dot product out of them. -}

dotp_2level start1 start2 start3 start4 len =
  dotp_internal [:a1..a2:] [:a1..a2:]
  where
    a1 = dotp_internal [:start1..((Prelude.+) start1 len):] [:start2..((Prelude.+) start2 len):]
    a2 = dotp_internal [:start3..((Prelude.+) start3 len):] [:start4..((Prelude.+) start4 len):]
