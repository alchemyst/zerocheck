FILENAME?=$$HOME/tmp/zero
REPEATS?=20
RESULTS?=results.csv

rust_path = ./rust/zerochecker
rust_binary = ${rust_path}/target/release/zerochecker
cpp_path = ./cpp
cpp_binary = ${cpp_path}/zerochecker ${cpp_path}/zerochecker_vec
haskell_path = ./haskell
haskell_binary = ${haskell}/zerochecker
swift_path = ./swift
swift_binary = ${swift_path}/zerochecker
csharp_path = ./csharp
csharp_binary = ${csharp_path}/zerochecker.dll
go_path = ./go
go_binary = ${go_path}/zerochecker

# https://stackoverflow.com/questions/714100/os-detecting-makefile
UNAME_S = $(shell uname -s)
OS_target = default
ifeq ($(UNAME_S),Darwin)
	OS_target = macOS
endif


bench: $(OS_target)

builds: rust cpp haskell swift csharp go

default: $(RESULTS)

# Replace with your favourite notify script
macOS: $(RESULTS)
	notify "Bench complete"

$(FILENAME):
	dd if=/dev/zero of=$(FILENAME) bs=100k count=20k

$(RESULTS): $(FILENAME)
	python bench.py commands $(FILENAME) --repeats $(REPEATS) --output $(RESULTS) --verbose

rust: ${rust_binary}

${rust_binary}: 
	cargo build --release --manifest-path ${rust_path}/Cargo.toml
	cp ${rust_binary} ./rust/zerocheck

cpp: ${cpp_binary}

${cpp_binary}:
	${MAKE} -C ${cpp_path}

haskell: ${haskell_binary}

${haskell_binary}:
	${MAKE} -C ${haskell_path}

swift: ${swift_binary}

${swift_binary}:
	${MAKE} -C ${swift_path}

csharp: ${csharp_binary}

${csharp_binary}:
	${MAKE} -C ${csharp_path}

go: ${go_binary}

${go_binary}:
	${MAKE} -C ${go_path}

clean: clean-builds

clean-builds: clean-rust clean-cpp clean-haskell clean-swift clean-csharp clean-go

clean-rust:
	cargo clean --manifest-path ${rust_path}/Cargo.toml
	-rm ${rust_path}/../zerocheck

clean-cpp:
	${MAKE} clean -C ${cpp_path}

clean-haskell:
	${MAKE} clean -C ${haskell_path}

clean-swift:
	${MAKE} clean -C ${swift_path}

clean-csharp:
	${MAKE} clean -C ${csharp_path}

clean-go:
	${MAKE} clean -C ${go_path}

.PHONY: bench builds clean clean-builds clean-rust clean-cpp clean-haskell \
	clean-swift clean-csharp clean-go default rust cpp haskell csharp swift go
