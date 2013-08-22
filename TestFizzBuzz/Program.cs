using System;
using System.Linq;

namespace TestFizzBuzz
{
    class Program
    {
        static void Main()
        {
            foreach (var s in Enumerable.Range(1, 20).FizzBuzz(t => t % 3 == 0, t => t % 5 == 0))
            {
                Console.WriteLine(s);
            }
            Console.ReadKey(true);
            foreach (var s in Enumerable.Range(1,20))
            {
                Console.WriteLine(s.FizzBuzz(t => t%3 == 0, t => t%5 == 0));
            }
            Console.ReadKey(true);
        }
    }
}
