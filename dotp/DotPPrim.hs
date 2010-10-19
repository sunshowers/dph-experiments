module DotPPrim where
import Data.Array.Parallel.Unlifted as U

dotp v w = U.sum (U.zipWith (*) v w)

dotp_2level v1 v2 w1 w2 =
  dotp (U.enumFromTo a (a + 3)) (U.enumFromTo b (b + 3))
  where
    a = dotp v1 v2
    b = dotp w1 w2
