using System;
using System.Linq;

namespace TestFizzBuzz
{
    class Program
    {
        private static void Main()
        {
            foreach (var s in Enumerable.Range(1, 200).FizzBuzz())
            {
                Console.WriteLine(s);
            }
            Console.ReadKey(true);
        }
    }
}
