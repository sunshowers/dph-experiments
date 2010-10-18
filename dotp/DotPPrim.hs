module DotPPrim where
import Data.Array.Parallel.Unlifted as U

dotp v w = U.sum (U.zipWith (*) v w)
