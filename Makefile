filename = ~/tmp/zero
REPEATS = 10

rust_path = ./rust/zerochecker
rust_binary = ${rust_path}/target/release/zerochecker
cpp_path = ./cpp
cpp_binary = ${cpp_path}/zerochecker ${cpp_path}/zerochecker_vec
haskell_path = ./haskell
haskell_binary = ${haskell}/zerochecker

bench: results.csv

builds: rust cpp haskell

$(filename):
	dd if=/dev/zero of=$(filename) bs=10M count=300

results.csv: $(filename)
	python bench.py commands $(filename) --repeats $(REPEATS) --output results.csv
	notify "Bench complete"

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

.PHONY: bench builds clean clean-builds clean-rust clean-cpp clean-haskell rust cpp haskell
