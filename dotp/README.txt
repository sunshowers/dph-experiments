CS497 work on Data Parallel Haskell
===================================
Siddharth Agarwal | Y7429

To build, run `make`.

The unlifted implementation (non-vectorized) works really well, but can't really
do multi-level vectorization and all the tricks that a vectorized implementation
would do.

The vectorized implementation is really buggy. Problems with the current
implementation:

1. enumFromTo isn't vectorizable. This means that code with the order of
instructions:
    a1 = dotp v1 v1
    a2 = dotp v2 v2
    v = [:a1..a2:]
    dotp v v
doesn't work.
