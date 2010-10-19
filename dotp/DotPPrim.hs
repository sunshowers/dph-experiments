module DotPPrim where
import Data.Array.Parallel.Unlifted as U

dotp v w = U.sum (U.zipWith (*) v w)

dotp_2level v1 v2 w1 w2 =
  dotp vsum wsum
  where
    vsum = U.zipWith (+) v1 v2
    wsum = U.zipWith (+) w1 w2
