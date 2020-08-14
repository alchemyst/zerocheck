import numpy
import sys

filename = sys.argv[1]

arr = numpy.memmap(filename, mode='r')

if not arr.any():
    print(filename)
