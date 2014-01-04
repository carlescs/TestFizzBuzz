using System.Linq;
using NUnit.Framework;

namespace TestFizzBuzz.Tests
{
    [TestFixture]
    public class FizzBuzzTests
    {
        private string[] _fizzbuzz;

        [SetUp]
        public void SetupTests()
        {
            var elems = Enumerable.Range(0, 16);
            _fizzbuzz = elems.FizzBuzz().ToArray();
        }

        [TestCase("Fizz",3)]
        [TestCase("Buzz",5)]
        [TestCase("FizzBuzz",15)]
        public void FizzBuzzTestSpecialCases(string expected,int index)
        {
            Assert.AreEqual(expected,_fizzbuzz[index]);
        }

        [Test]
        public void TestAll()
        {
            for (var i = 0; i < _fizzbuzz.Length; i++)
            {
                if (i%3 == 0)
                {
                    Assert.AreEqual(i%5 == 0 ? "FizzBuzz" : "Fizz", _fizzbuzz[i]);
                }
                else if (i%5 == 0)
                {
                    Assert.AreEqual("Buzz",_fizzbuzz[i]);
                }
                else
                {
                    Assert.AreEqual(string.Format("{0}",i),_fizzbuzz[i]);
                }
            }
        }
    }
}
