#!/usr/bin/env

import os
import argparse
import time
import random
import pandas
from tqdm import tqdm 

parser = argparse.ArgumentParser()
parser.add_argument('commands')
parser.add_argument('filename')
parser.add_argument('--repeats', type=int, default=1)
parser.add_argument('--print', action='store_true')
parser.add_argument('--output', '-o', type=argparse.FileType('w'))
args = parser.parse_args()

commands = [line.strip() for line in open(args.commands) if line.strip() and not line.startswith('#')]

order = list(range(0, len(commands)))*args.repeats
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

df = pandas.DataFrame({'command': [commands[i] for i in order], 'time': results})

if args.output:
    df.to_csv(args.output)

