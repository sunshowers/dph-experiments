# The Haskell compiler
HSC = ghc

# Windows vs Linux
HOST_OS := $(shell uname -o)
ifeq ($(HOST_OS),GNU/Linux)
BIN_SUFFIX =
else
BIN_SUFFIX = .exe
endif

GENERAL_ARGS = -fcpr-off -threaded -Odph -funbox-strict-fields --make

PROGRAMS = prim-par$(BIN_SUFFIX) vect-par$(BIN_SUFFIX) prim-seq$(BIN_SUFFIX) vect-seq$(BIN_SUFFIX)

# Build all the programs by default
default: $(PROGRAMS)

prim-par$(BIN_SUFFIX): dotptest.hs DotPPrim.hs
	$(HSC) -DUNLIFTED $(GENERAL_ARGS) -fdph-par -o $@ $<

vect-par$(BIN_SUFFIX): dotptest.hs DotPVect.hs
	$(HSC) $(GENERAL_ARGS) -fdph-par -o $@ $<

prim-seq$(BIN_SUFFIX): dotptest.hs DotPPrim.hs
	$(HSC) -DUNLIFTED $(GENERAL_ARGS) -fdph-seq -o $@ $<

vect-seq$(BIN_SUFFIX): dotptest.hs DotPVect.hs
	$(HSC) $(GENERAL_ARGS) -fdph-seq -o $@ $<

clean:
	$(RM) $(PROGRAMS) *.o *.hi
