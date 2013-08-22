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
            return enumerable.Select(i => FizzBuzz(i, testFizz, testBuzz));
        }

        public static string FizzBuzz<T>(this T i, Predicate<T> testFizz, Predicate<T> testBuzz)
        {
            if (!testFizz.Invoke(i) && !testBuzz.Invoke(i))
                return string.Format("{0}", i);
            var sb = new StringBuilder();
            if (testFizz.Invoke(i))
                sb.Append("Fizz");
            if (testBuzz.Invoke(i))
                sb.Append("Buzz");
            return sb.ToString();
        }
    }
}