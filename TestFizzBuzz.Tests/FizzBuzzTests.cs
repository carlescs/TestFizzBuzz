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

        _fizzbuzzStrings = elems.Select(t=> t.ToString()).FizzBuzz(t=>t.EndsWith("3"),t=>t.EndsWith("5")).ToArray();
    }

    [Theory]
    [InlineData("Fizz",3)]
    [InlineData("Buzz",5)]
    [InlineData("FizzBuzz",15)]
    [InlineData("22", 22)]
    public void FizzBuzzTestSpecialCases(string expected, int index)
    {
        Assert.Equal(expected,_fizzbuzz[index]);
    }

    [Fact]
    public void TestAll()
    {
        for (var i = 0; i < _fizzbuzz.Length; i++)
        {
            if (i%3 == 0)
            {
                Assert.Equal(i%5 == 0 ? "FizzBuzz" : "Fizz", _fizzbuzz[i]);
            }
            else if (i%5 == 0)
            {
                Assert.Equal("Buzz",_fizzbuzz[i]);
            }
            else
            {
                Assert.Equal($"{i}",_fizzbuzz[i]);
            }
        }
    }

    [Theory]
    [InlineData("Fizz",3)]
    [InlineData("Buzz",5)]
    [InlineData("Buzz",15)]
    [InlineData("21", 21)]
    public void FizzBuzzTestSpecialCasesStrings(string expected, int index)
    {
        Assert.Equal(expected, _fizzbuzzStrings[index]);
    }
}