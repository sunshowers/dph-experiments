# The Haskell compiler
HSC = ghc

# Windows vs Linux
HOST_OS := $(shell uname -o)
ifeq ($(HOST_OS),GNU/Linux)
BIN_SUFFIX =
else
BIN_SUFFIX = .exe
endif

PROGRAMS = prim-par$(BIN_SUFFIX) vect-par$(BIN_SUFFIX) prim-seq$(BIN_SUFFIX) vect-seq$(BIN_SUFFIX)

# Build all the programs by default
default: $(PROGRAMS)

dotptestprim-par.o: dotptest.hs
	$(HSC) -DUNLIFTED -c -O -fdph-par -o $@ $^

dotptestprim-seq.o: dotptest.hs
	$(HSC) -DUNLIFTED -c -O -fdph-seq -o $@ $^

dotptestvect-par.o: dotptest.hs
	$(HSC) -c -O -fdph-par -o $@ $^

dotptestvect-seq.o: dotptest.hs
	$(HSC) -c -O -fdph-seq -o $@ $^

DotPPrim-par.o: DotPPrim.hs
	$(HSC) -c -Odph -fcpr-off -fdph-par -o $@ $^

DotPPrim-seq.o: DotPPrim.hs
	$(HSC) -c -Odph -fcpr-off -fdph-seq -o $@ $^

DotPVect-par.o: DotPVect.hs
	$(HSC) -c -Odph -fcpr-off -fdph-par -o $@ $^

DotPVect-seq.o: DotPVect.hs
	$(HSC) -c -Odph -fcpr-off -fdph-seq -o $@ $^

prim-par$(BIN_SUFFIX): dotptestprim-par.o DotPPrim-par.o
	$(HSC) -o $@ -fdph-par -threaded $^

prim-seq(BIN_SUFFIX): dotptestprim-seq.o DotPPrim-seq.o
	$(HSC) -o $@ -fdph-seq -threaded $^

vect-par$(BIN_SUFFIX): dotptestvect-par.o DotPVect-par.o
	$(HSC) -o $@ -fdph-par -threaded $^

vect-seq$(BIN_SUFFIX): dotptestvect-seq.o DotPVect-seq.o
	$(HSC) -o $@ -fdph-seq -threaded $^

clean:
	$(RM) $(PROGRAMS) *.o *.hi
