all: main
main: lib/*.hs
	cd lib/ && ghc main.hs && cp main ../bin/skua-lisp

