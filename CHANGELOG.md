# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - Dependencies Update

### Changed
- Updated target framework from .NET 9.0 to .NET 8.0 for better compatibility
- Updated NuGet packages to latest versions:
  - `coverlet.collector`: 6.0.2 → 6.0.4
  - `Microsoft.NET.Test.Sdk`: 17.12.0 → 17.14.1  
  - `xunit`: 2.9.2 → 2.9.3
  - `xunit.runner.console`: 2.9.2 → 2.9.3
  - `xunit.runner.visualstudio`: 2.8.2 → 3.1.4

### Migration Notes
- No breaking changes introduced
- All existing tests continue to pass
- Application functionality remains unchanged
- The xunit.runner.visualstudio package had a major version update (2.8.2 → 3.1.4) but maintains backward compatibility

### Verification
- All 9 unit tests pass successfully
- Build completes without warnings or errors
- Application runs correctly and produces expected FizzBuzz output