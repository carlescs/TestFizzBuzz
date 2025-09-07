# TestFizzBuzz - .NET Console Application

TestFizzBuzz is a .NET 9.0 console application that implements a generic FizzBuzz algorithm with extension methods. The solution includes a main console application and comprehensive unit tests using xUnit.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Project Structure

```
TestFizzBuzz/
├── TestFizzBuzz/                    # Main console application
│   ├── Program.cs                   # Entry point - prints FizzBuzz 1-200
│   ├── FizzBuzzExtensions.cs        # Generic FizzBuzz extension methods
│   └── TestFizzBuzz.csproj         # Project file targeting net9.0
├── TestFizzBuzz.Tests/              # Unit test project
│   ├── FizzBuzzTests.cs            # Comprehensive xUnit tests
│   └── TestFizzBuzz.Tests.csproj   # Test project with xUnit dependencies
├── TestFizzBuzz.sln                # Solution file
├── .github/workflows/dotnet.yml    # GitHub Actions CI/CD
└── azure-pipelines.yml             # Azure DevOps pipeline
```

## Working Effectively

### Bootstrap, Build, and Test the Repository
- Navigate to repository root: `cd /path/to/TestFizzBuzz`
- Restore dependencies: `dotnet restore` -- takes ~1-5 seconds. Set timeout to 60+ seconds.
- Build solution: `dotnet build --no-restore` -- takes ~3-4 seconds. Set timeout to 60+ seconds.
- Run tests: `dotnet test --no-build --verbosity normal` -- takes ~1 second. Set timeout to 30+ seconds.

### Run the Application
- **Console Application**: `dotnet run --project TestFizzBuzz --no-build`
- **IMPORTANT**: The application prints FizzBuzz numbers 1-200 then calls `Console.ReadKey(true)` which waits for user input
- **For Non-Interactive Environments**: The application will throw `System.InvalidOperationException` when console input is redirected
- **Expected Output**: Numbers 1-200 with multiples of 3 as "Fizz", multiples of 5 as "Buzz", multiples of both as "FizzBuzz"

## Validation

### Manual Testing Scenarios
- **Always test the core FizzBuzz logic after making changes**:
  1. Run `dotnet test --no-build` and verify all 9 tests pass
  2. Run `echo "" | dotnet run --project TestFizzBuzz --no-build | head -20` to verify output:
     - Should see: 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz
  3. Run `echo "" | dotnet run --project TestFizzBuzz --no-build | tail -10` to verify final output:
     - Should see: 191, Fizz, 193, 194, FizzBuzz, 196, 197, Fizz, 199, Buzz
  4. Verify the exception handling for Console.ReadKey() in non-interactive mode is expected behavior

### Build Validation
- **Always run the full build sequence** before committing changes:
  ```bash
  dotnet restore
  dotnet build --no-restore
  dotnet test --no-build --verbosity normal
  ```
- All commands should complete successfully with exit code 0
- Test output should show "Test summary: total: 9, failed: 0, succeeded: 9, skipped: 0"

## Key Files to Check After Changes
- **Always review `TestFizzBuzz/FizzBuzzExtensions.cs`** when modifying the FizzBuzz logic
- **Always run tests in `TestFizzBuzz.Tests/FizzBuzzTests.cs`** to verify behavior
- **Check Program.cs** only when modifying the console application entry point

### CI/CD Integration
- **GitHub Actions**: `.github/workflows/dotnet.yml` runs on Ubuntu with .NET 9.0
- **Azure Pipelines**: `azure-pipelines.yml` includes SonarCloud analysis and Qodana scanning
- Both pipelines run: restore → build → test sequence

## Troubleshooting

### Common Issues
- **Console.ReadKey() Exception**: Expected behavior in non-interactive environments. Use input redirection: `echo "" | dotnet run --project TestFizzBuzz`
- **Build Failures**: Always run `dotnet clean` then the full build sequence if you encounter unexplained build issues

### Performance Expectations
- **Restore**: ~1-5 seconds (first time slower, subsequent runs faster)
- **Build**: ~3-4 seconds for full solution
- **Test**: ~1 second for all 9 tests
- **Total development cycle**: ~5-10 seconds from clean to tested

### Dependencies
The project uses minimal dependencies:
- **.NET 9.0**: Target framework
- **xUnit 2.9.2**: Testing framework  
- **Microsoft.NET.Test.Sdk 17.12.0**: Test SDK
- **coverlet.collector 6.0.2**: Code coverage collector

## Code Quality Standards
- **No linting tools configured** - standard .NET compiler warnings apply
- **Test Coverage**: Maintain comprehensive test coverage for FizzBuzz logic
- **Code Style**: Follow standard C# conventions, existing code uses minimal documentation
- **Extension Method Pattern**: The codebase uses a generic extension method pattern:
  - `FizzBuzz<T>(IEnumerable<T>, Predicate<T>, Predicate<T>)` - generic version with custom predicates
  - `FizzBuzz(IEnumerable<int>)` - convenience method for standard divisibility rules (3 and 5)
- **Key Logic**: Uses `StringBuilder` for efficient string concatenation in `FizzBuzzElem` method

## Semantic Commit Guidelines

This project follows **Conventional Commits** specification for semantic commits and automated versioning.

### Commit Message Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Commit Types
- **feat**: A new feature (triggers minor version bump)
- **fix**: A bug fix (triggers patch version bump)  
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc.)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to CI configuration files and scripts
- **chore**: Other changes that don't modify src or test files

### Breaking Changes
- Add `BREAKING CHANGE:` in the footer or append `!` after the type/scope
- Triggers major version bump
- Example: `feat!: remove deprecated FizzBuzz overload`

### Commit Message Examples
```bash
# Feature with detailed body
feat: add generic FizzBuzz method with custom predicates

This commit introduces a new generic extension method that allows
users to define custom predicates for Fizz and Buzz conditions,
making the FizzBuzz algorithm more flexible and reusable.

- Added FizzBuzz<T>(IEnumerable<T>, Predicate<T>, Predicate<T>) method
- Maintained backward compatibility with existing int-based method
- Updated unit tests to cover new functionality

# Bug fix
fix: handle null input in FizzBuzz extension method

# Documentation update  
docs: update README with usage examples

# Breaking change
feat!: change FizzBuzz return type to IAsyncEnumerable

BREAKING CHANGE: FizzBuzz methods now return IAsyncEnumerable<string> 
instead of IEnumerable<string> to support async scenarios
```

### Copilot Commit Instructions
When creating commits, **always**:
1. **Use semantic commit format** with appropriate type prefix
2. **Write detailed commit body** explaining:
   - What was changed and why
   - Any important implementation details  
   - Impact on existing functionality
   - Links to related issues or documentation
3. **Keep subject line under 50 characters**
4. **Wrap body text at 72 characters**
5. **Use imperative mood** in subject line ("add feature" not "added feature")
6. **Reference issues** in footer when applicable ("Fixes #123", "Closes #456")