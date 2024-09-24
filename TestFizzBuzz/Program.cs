using System;
using System.Diagnostics.CodeAnalysis;
using System.Linq;

namespace TestFizzBuzz;

[ExcludeFromCodeCoverage]
internal static class Program
{
    public static void Main(string[] args)
    {
        foreach (var s in Enumerable.Range(1, 200).FizzBuzz())
        {
            Console.WriteLine(s);
        }
        Console.ReadKey(true);
    }
}