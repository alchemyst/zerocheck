C++ = clang++
CFLAGS = -O3

TARGETS = zerochecker zerochecker_vec

all: $(TARGETS)

%: %.cpp
	$(C++) $(CFLAGS) $< -o $@

clean:
	-rm $(TARGETS)

PHONY: clean