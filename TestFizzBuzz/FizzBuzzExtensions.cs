using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestFizzBuzz;

/// <summary>
/// Provides extension methods for performing FizzBuzz operations on collections.
/// </summary>
public static class FizzBuzzExtensions
{
    /// <summary>
    /// Performs FizzBuzz operation on the elements of the collection based on the provided predicates.
    /// </summary>
    /// <typeparam name="T">The type of elements in the collection.</typeparam>
    /// <param name="enumerable">The collection to perform FizzBuzz operation on.</param>
    /// <param name="testFizz">The predicate to test if an element should be replaced with the fizz label.</param>
    /// <param name="testBuzz">The predicate to test if an element should be replaced with the buzz label.</param>
    /// <param name="fizzLabel">Label used when the fizz predicate matches. Defaults to "Fizz".</param>
    /// <param name="buzzLabel">Label used when the buzz predicate matches. Defaults to "Buzz".</param>
    /// <returns>An enumerable of strings representing the FizzBuzz operation results.</returns>
    public static IEnumerable<string> FizzBuzz<T>(this IEnumerable<T> enumerable, Predicate<T> testFizz, Predicate<T> testBuzz, string fizzLabel = "Fizz", string buzzLabel = "Buzz")
    {
        return enumerable.Select(i => FizzBuzzElem(i, testFizz, testBuzz, fizzLabel, buzzLabel));
    }

    /// <summary>
    /// Performs FizzBuzz operation on the elements of the collection using the default Fizz and Buzz predicates.
    /// </summary>
    /// <param name="enumerable">The collection to perform FizzBuzz operation on.</param>
    /// <param name="fizzLabel">Label used when the fizz predicate matches. Defaults to "Fizz".</param>
    /// <param name="buzzLabel">Label used when the buzz predicate matches. Defaults to "Buzz".</param>
    /// <returns>An enumerable of strings representing the FizzBuzz operation results.</returns>
    public static IEnumerable<string> FizzBuzz(this IEnumerable<int> enumerable, string fizzLabel = "Fizz", string buzzLabel = "Buzz")
    {
        return enumerable.FizzBuzz(t => t % 3 == 0, t => t % 5 == 0, fizzLabel, buzzLabel);
    }

    /// <summary>
    /// Performs FizzBuzz operation on a single element based on the provided predicates.
    /// </summary>
    /// <typeparam name="T">The type of the element.</typeparam>
    /// <param name="i">The element to perform FizzBuzz operation on.</param>
    /// <param name="testFizz">The predicate to test if the element should be replaced with the fizz label.</param>
    /// <param name="testBuzz">The predicate to test if the element should be replaced with the buzz label.</param>
    /// <param name="fizzLabel">Label used when the fizz predicate matches. Defaults to "Fizz".</param>
    /// <param name="buzzLabel">Label used when the buzz predicate matches. Defaults to "Buzz".</param>
    /// <returns>A string representing the FizzBuzz operation result for the element.</returns>
    private static string FizzBuzzElem<T>(this T i, Predicate<T> testFizz, Predicate<T> testBuzz, string fizzLabel, string buzzLabel)
    {
        if (!testFizz(i) && !testBuzz(i))
        {
            return $"{i}";
        }
        var sb = new StringBuilder();
        if (testFizz(i))
        {
            sb.Append(fizzLabel);
        }
        if (testBuzz(i))
        {
            sb.Append(buzzLabel);
        }
        return sb.ToString();
    }
}
