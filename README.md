TestFizzBuzz
============

A generic FizzBuzzTest implementing semantic commits and automated versioning.

## Overview

This .NET 9.0 console application demonstrates:
- Generic FizzBuzz algorithm with extension methods
- Comprehensive unit testing with xUnit
- **Semantic commit conventions** with automated versioning
- CI/CD integration with GitHub Actions and Azure DevOps

## Quick Start

```bash
# Clone and build
git clone https://github.com/carlescs/TestFizzBuzz.git
cd TestFizzBuzz
dotnet restore
dotnet build
dotnet test

# Run application
dotnet run --project TestFizzBuzz
```

## Semantic Commits

This project uses [Conventional Commits](https://www.conventionalcommits.org/) for automated semantic versioning.

### Commit Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Examples
```bash
feat: add custom predicates support        # Minor version bump
fix: handle null input gracefully          # Patch version bump  
feat!: change return type to async         # Major version bump
docs: update README with examples          # No version bump
```

**📖 See [Semantic Commits Guide](docs/SEMANTIC_COMMITS.md) for detailed conventional commits documentation**  
**📖 See [Changelog Automation Guide](docs/CHANGELOG_AUTOMATION.md) for automated changelog documentation**

## Versioning

Versions are automatically calculated using [GitVersion](https://gitversion.net/) based on commit messages:

- **Major** (1.0.0): Breaking changes (`feat!:` or `BREAKING CHANGE:`)  
- **Minor** (0.1.0): New features (`feat:`)
- **Patch** (0.0.1): Bug fixes (`fix:`) and performance improvements (`perf:`)

Current version is embedded in assemblies during build and shown in CI/CD pipelines.

## Development

### Prerequisites
- .NET 9.0 SDK
- Git with semantic commit template configured

### Setup
```bash
# Configure git commit template
git config commit.template .gitmessage

# Install GitVersion (optional, for local version testing)
dotnet tool install --global GitVersion.Tool

# Check current version
dotnet gitversion
```

### Building
```bash
dotnet restore
dotnet build --configuration Release    # Includes semantic versioning
dotnet test --verbosity normal
```

## CI/CD

- **GitHub Actions**: Automated builds, tests, releases, and changelog generation
- **Azure DevOps**: SonarCloud analysis and Qodana scanning  
- **Versioned Artifacts**: All builds tagged with semantic versions
- **Automated Releases**: Created for master branch with automated changelog
- **Automated Changelog**: Generated from conventional commits in pull requests, included in PR diffs before merge
