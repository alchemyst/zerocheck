#!/usr/bin/env

from collections import defaultdict
import os
import argparse
import pathlib
import time
import random

import pandas as pd
from tqdm.auto import tqdm 

parser = argparse.ArgumentParser()
parser.add_argument('commands')
parser.add_argument('filename')
parser.add_argument('--repeats', type=int, default=1)
parser.add_argument('--print', action='store_true', help="Print times to output")
parser.add_argument('--output', '-o', type=pathlib.Path)
parser.add_argument('--verbose', action='store_true', help="Print more output")
args = parser.parse_args()

def verbose(string):
    if args.verbose:
        print(string)

counts = defaultdict(int)

if args.output and args.output.is_file():
    verbose("Found previous results - reading")
    previous_df = pd.read_csv(args.output)
    previous_counts = previous_df.groupby("command")["time"].count()
    counts.update(zip(previous_counts.index, previous_counts.values))

commands = [line.strip() for line in open(args.commands) if line.strip() and not line.startswith('#')]

# Queue up (only) the extra runs required
order = []
for i, command in enumerate(commands):
    already_done = counts[command]
    required_runs = max(0, args.repeats - already_done)
    verbose(f"{required_runs}\t{command}")
    order += [i]*required_runs

random.shuffle(order)

results = []
for index in tqdm(order):
    command = commands[index]
    start = time.perf_counter()
    os.system(command.format(args.filename) + " > /dev/null")
    elapsed = time.perf_counter() - start
    results.append(elapsed)
    if args.print:
        print(command, elapsed)

if args.output:
    new_df = pd.DataFrame({'command': [commands[i] for i in order], 'time': results})
    combined = pd.concat([previous_df, new_df])
    combined.to_csv(args.output, index=False)

