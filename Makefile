FILENAME?=$$HOME/tmp/zero
REPEATS = 1

bench: results.csv

$(FILENAME):
	dd if=/dev/zero of=$(FILENAME) bs=100k count=20k

results.csv: $(FILENAME) targets
	python bench.py commands $(FILENAME) --repeats $(REPEATS) --output results.csv
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
