#!/usr/bin/env python

import os
import sys

MAXCHUNK = 1024**3

def zerofile(filename):
    chunksize = 100
    with open(filename, 'rb') as f:
        while True:
            chunk = f.read(chunksize)
            if not chunk:
                break

            for byte in chunk:
                if byte != 0:
                    return False

            chunksize = max(2*chunksize, MAXCHUNK)

    return True

if __name__ == "__main__":
    filename = sys.argv[1]
    if zerofile(filename):
        print(filename)
