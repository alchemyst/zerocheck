# Check files for zero contents

This mini-benchmark was born when I had to check my drive for files which contained only zero bytes due to a OneDrive malfunction.

If you'd like to play along, write a program in your favourite language that does the following:

* Accept a commandline argument filename
* Terminate with no output if the file contains anything other than a zero byte
* Print filename to stdout if the file contains only zero bytes

You may assume that the file is small enough to fit in memory.

