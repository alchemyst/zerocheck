using System;
using System.IO;

class MainClass
{    public static void Main (string[] args)
    {
        if (args.Length != 1) {
            Console.Write("Invalid arguments");
            Environment.Exit(2);
        }

        var filename = args[0];
        
		foreach (var b in File.ReadAllBytes(filename)) {
            if (b != 0) {
                Environment.Exit(0);
            }
        }

        Console.WriteLine(filename);
    }
}
