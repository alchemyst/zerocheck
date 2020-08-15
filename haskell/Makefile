TARGETS = zerochecker zerochecker.hi zerochecker.o

${TARGETS}: zerochecker.hs
	ghc -O3 $<

clean:
	-rm ${TARGETS}

.PHONY: clean