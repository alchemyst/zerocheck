using Mmap

if length(ARGS) != 1
    println("Invalid arguments")
    exit(2)
end

filename = ARGS[1]

contents = Mmap.mmap(filename)

if all(contents .== 0)
    println(filename)
end
