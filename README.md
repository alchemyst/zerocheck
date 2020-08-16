# Check files for zero contents

This mini-benchmark was born when I had to check my drive for files which contained only zero bytes due to a OneDrive malfunction.

If you'd like to play along, write a program in your favourite language that does the following:

* Accept a commandline argument filename
* Terminate with no output if the file contains anything other than a zero byte
* Print filename to stdout if the file contains only zero bytes

You may assume that the file is small enough to fit in memory.

## Docker

If you don't want to install all of compilers used in this benchmark, the included Dockerfile containerizes them for you.

Build the image in the normal way. This will take awhile, you are downloading a tonne of compilers:

```bash
docker build -t zerocheck .
```

After building the image, you can create a container:

```bash
docker run --rm -v ${PWD}:/home/jovyan/zerocheck -p 8888:8888 --name zerocheck zerocheck
```

Copy the URL echoed to your terminal into your browser of choice to open the Jupyter Notebook.

Open a new terminal window to run a shell on the container, so you can build and run the benchmarks:

```bash
docker exec -it zerocheck /bin/bash
cd zerocheck
make builds
make FILENAME=./tmp/zero bench
```

You can now open the Jupyter notebook and plot the results:

http://127.0.0.1:8888/notebooks/work/Analyse%20results.ipynb