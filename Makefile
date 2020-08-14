filename = ~/tmp/zero
REPEATS = 10

bench: results.csv

$(filename):
	dd if=/dev/zero of=$(filename) bs=10m count=300

results.csv: $(filename)
	python bench.py commands $(filename) --repeats $(REPEATS) --output results.csv
	notify "Bench complete"

.PHONY: bench
