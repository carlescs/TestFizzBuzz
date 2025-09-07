using System.Linq;
using Xunit;

namespace TestFizzBuzz.Tests;

public class FizzBuzzTests
{
    private readonly string[] _fizzbuzz;
    private readonly string[] _fizzbuzzStrings;

    public FizzBuzzTests()
    {
        var elems = Enumerable.Range(0, 100).ToList();
        _fizzbuzz = elems.FizzBuzz().ToArray();

        _fizzbuzzStrings = elems.Select(t => t.ToString()).FizzBuzz(t => t.EndsWith('3'), t => t.EndsWith('5')).ToArray();
    }

    // Comprehensive test that validates the standard int-based FizzBuzz for the whole range
    [Fact]
    public void TestAll()
    {
        for (var i = 0; i < _fizzbuzz.Length; i++)
        {
            if (i % 3 == 0)
            {
                Assert.Equal(i % 5 == 0 ? "FizzBuzz" : "Fizz", _fizzbuzz[i]);
            }
            else if (i % 5 == 0)
            {
                Assert.Equal("Buzz", _fizzbuzz[i]);
            }
            else
            {
                Assert.Equal($"{i}", _fizzbuzz[i]);
            }
        }
    }

    // Small regression test for representative cases
    [Theory]
    [InlineData("Fizz", 3)]
    [InlineData("Buzz", 5)]
    [InlineData("FizzBuzz", 15)]
    public void FizzBuzz_IntRegression(string expected, int index)
    {
        Assert.Equal(expected, _fizzbuzz[index]);
    }

    // Tests for the string-based overload using custom EndsWith predicates
    [Theory]
    [InlineData("Fizz", 3)]
    [InlineData("Buzz", 5)]
    [InlineData("Buzz", 15)]
    [InlineData("21", 21)]
    public void FizzBuzzTestSpecialCasesStrings(string expected, int index)
    {
        Assert.Equal(expected, _fizzbuzzStrings[index]);
    }

    // Negative numbers and zero behavior for the int-based overload
    [Fact]
    public void FizzBuzz_NegativeAndZero()
    {
        var list = new[] { -15, -5, -3, -1, 0, 1, 2 };
        var res = list.FizzBuzz().ToArray();
        Assert.Equal(new[] { "FizzBuzz", "Buzz", "Fizz", "-1", "FizzBuzz", "1", "2" }, res);
    }

    // Custom predicate combinations for a non-numeric sequence
    [Fact]
    public void FizzBuzz_CustomPredicates_AllFizzOrBuzz()
    {
        var list = new[] { "a", "b", "c" };

        var resFizz = list.FizzBuzz(_ => true, _ => false).ToArray();
        Assert.All(resFizz, s => Assert.Equal("Fizz", s));

        var resBuzz = list.FizzBuzz(_ => false, _ => true).ToArray();
        Assert.All(resBuzz, s => Assert.Equal("Buzz", s));

        var resBoth = list.FizzBuzz(_ => true, _ => true).ToArray();
        Assert.All(resBoth, s => Assert.Equal("FizzBuzz", s));
    }
}