filename = $$HOME/tmp/zero
REPEATS = 10

bench: results.csv

$(filename):
	dd if=/dev/zero of=$(filename) bs=100k count=300k

results.csv: $(filename) targets
	python bench.py commands $(filename) --repeats $(REPEATS) --output results.csv
	notify "Bench complete"

targets: cpp swift rust csharp haskell

cpp: 
	$(MAKE) -C cpp

swift:
	$(MAKE) -C swift

csharp:
	$(MAKE) -C csharp

haskell:
    $(MAKE) -C haskell

.PHONY: bench cpp swift csharp haskell targets
