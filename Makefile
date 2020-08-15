filename := $$HOME/tmp/zero
REPEATS = 1

bench: results.csv

$(filename):
	dd if=/dev/zero of=$(filename) bs=10m count=300

results.csv: $(filename) targets
	python bench.py commands $(filename) --repeats $(REPEATS) --output results.csv
	notify "Bench complete"

targets: cpp swift rust csharp

cpp: 
	$(MAKE) -C cpp

swift:
	$(MAKE) -C swift

csharp:
	$(MAKE) -C csharp

.PHONY: bench cpp swift csharp targets
