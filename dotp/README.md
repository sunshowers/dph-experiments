CS497 work on Data Parallel Haskell
===================================
Siddharth Agarwal | Y7429

To build, run `make`. The code has been tested with GHC 6.12.3 on Windows and
Linux.

The unlifted implementation (non-vectorized) works really well, but can't really
do multi-level vectorization and all the tricks that a vectorized implementation
would do.

The vectorized implementation is really buggy and immature right now. Problems
with the current implementation:

1. The normal `Prelude.+`, `Prelude.-`, `Prelude.*` etc aren't vectorizable,
since DPH apparently doesn't support type classes. The workaround is to use
`Data.Array.Parallel.Prelude.Int.+` or Float.+ etc.

2. Apparently you can't transfer parallel arrays of the type [:Int:] between
vectorized and non-vectorized code. Instead you need to use a wrapper function
that accepts `PArray Int`, and use `Data.Array.Parallel.Prelude.fromPArrayP` to
convert to an [:Int:].

3. The optimizer tended to inline the wrapper function into non-vectorized
code. We don't want that since it really is the interface between vectorized and
non-vectorized code. The solution is to mark it as NOINLINE. Ideally we wouldn't
have to worry about such things at all.

4. enumFromTo isn't vectorizable. This means that code with the order of
instructions doesn't work in purely vectorized code.

      a1 = dotp v1 v1
      a2 = dotp v2 v2
      v = [:a1..a2:]
      dotp v v

5. This means that the only way to do such a thing is to first do the individual
dot products, then get their results back into non-vectorized code, and finally
to move to vectorized code again. Unfortunately this sequence of operations
causes a stack overflow with both `dph-par` and `dph-seq`.

6. So instead of an enumFromTo, I tried to do something like

      dotp_internal [:a, ((I.+) a 1), ((I.+) a 2), ((I.+) a 3):]
                    [:b, ((I.+) b 1), ((I.+) b 2), ((I.+) b 3):]

    (i.e. explicitly doing the enumeration; see commit
9372997ee12b69f1cd9b6c855052dce2114e66ab). This works with `dph-seq` but not
with `dph-par`, and hence is a bug in the `dph-par` implementation.

The final code I have has this sequence of steps:
    vsum = parallel term-by-term sum of two arrays
    wsum = parallel term-by-term sum of two different arrays
    result = sum over all elements (term-by-term product of vsum and wsum)

This is a non-trivial multi-level vectorization, and hence it is good to see it
working! For arrays of 40 elements each, this sped things up from around 0.175
seconds with -N1 to 0.110 seconds with -N2 on my machine.
