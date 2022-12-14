using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestFizzBuzz
{
    public static class FizzBuzzExtensions
    {
        public static IEnumerable<string> FizzBuzz<T>(this IEnumerable<T> enumerable, Predicate<T> testFizz, Predicate<T> testBuzz)
        {
            return enumerable.Select(i => FizzBuzzElem(i, testFizz, testBuzz));
        }

        public static IEnumerable<string> FizzBuzz(this IEnumerable<int> enumerable)
        {
            return enumerable.FizzBuzz(t => t%3 == 0, t => t%5 == 0);
        } 

        private static string FizzBuzzElem<T>(this T i, Predicate<T> testFizz, Predicate<T> testBuzz)
        {
            if (!testFizz(i) && !testBuzz(i))
                return $"{i}";
            var sb = new StringBuilder();
            if (testFizz(i))
                sb.Append("Fizz");
            if (testBuzz(i))
                sb.Append("Buzz");
            return sb.ToString();
        }
    }
}