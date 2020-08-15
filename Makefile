filename = ~/tmp/zero
results = results.csv
REPEATS = 10

rust_path = ./rust/zerochecker
rust_binary = ${rust_path}/target/release/zerochecker
cpp_path = ./cpp
cpp_binary = ${cpp_path}/zerochecker ${cpp_path}/zerochecker_vec
haskell_path = ./haskell
haskell_binary = ${haskell}/zerochecker

# https://stackoverflow.com/questions/714100/os-detecting-makefile
UNAME_S := $(shell uname -s)
OS_target = default
ifeq ($(UNAME_S),Darwin)
	OS_target = macOS
endif


bench: $(OS_target)

builds: rust cpp haskell

default: $(results)

macOS: $results
	notify "Bench complete"

$(filename):
	dd if=/dev/zero of=$(filename) bs=10M count=300

$(results): $(filename)
	python bench.py commands $(filename) --repeats $(REPEATS) --output results.csv

rust: ${rust_binary}

${rust_binary}: 
	cargo build --release --manifest-path ${rust_path}/Cargo.toml

cpp: ${cpp_binary}

${cpp_binary}:
	${MAKE} -C ${cpp_path}

haskell: ${haskell_binary}

${haskell_binary}:
	${MAKE} -C ${haskell_path}

clean: clean-builds

clean-builds: clean-rust clean-cpp clean-haskell

clean-rust:
	cargo clean --manifest-path ${rust_path}/Cargo.toml

clean-cpp:
	${MAKE} clean -C ${cpp_path}

clean-haskell:
	${MAKE} clean -C ${haskell_path}

.PHONY: bench builds clean clean-builds clean-rust clean-cpp clean-haskell default rust cpp haskell
