# Semantic Commits and Versioning

This project uses **Conventional Commits** and **GitVersion** for automated semantic versioning.

## Quick Start

### Commit Message Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Common Examples
```bash
# New feature (minor version bump)
feat: add support for custom FizzBuzz predicates

# Bug fix (patch version bump)  
fix: handle null input in extension method

# Breaking change (major version bump)
feat!: change return type to async enumerable

BREAKING CHANGE: All FizzBuzz methods now return IAsyncEnumerable<string>
```

## Commit Types

| Type | Description | Version Impact |
|------|-------------|----------------|
| `feat` | New feature | Minor (0.1.0) |
| `fix` | Bug fix | Patch (0.0.1) |
| `docs` | Documentation only | None |
| `style` | Code formatting, no logic change | None |
| `refactor` | Code restructuring, no behavior change | None |
| `perf` | Performance improvements | Patch (0.0.1) |
| `test` | Adding or fixing tests | None |
| `build` | Build system changes | None |
| `ci` | CI configuration changes | None |
| `chore` | Maintenance tasks | None |

## Breaking Changes

- Add `!` after type: `feat!: new breaking feature`
- Or add `BREAKING CHANGE:` in footer
- Results in major version bump (1.0.0)

## Semantic Versioning

Versions follow `MAJOR.MINOR.PATCH` format:
- **MAJOR**: Breaking changes (incompatible API changes)
- **MINOR**: New features (backward compatible)  
- **PATCH**: Bug fixes (backward compatible)

### Branch Versioning Strategy

| Branch | Version Format | Example |
|--------|----------------|---------|
| `master` | `1.2.3` | Stable releases |
| `develop` | `1.2.3-alpha.4` | Development builds |
| `feature/*` | `1.2.3-alpha.4` | Feature development |
| `release/*` | `1.2.3-beta.1` | Release candidates |
| `hotfix/*` | `1.2.3-beta.1` | Hotfix builds |

## Setup Instructions

### Git Configuration
```bash
# Set commit message template
git config commit.template .gitmessage

# Enable commit message editor
git config core.editor "code --wait"  # VS Code
# or
git config core.editor "vim"          # Vim
```

### Local Development

1. **Install GitVersion** (optional for local testing):
   ```bash
   dotnet tool install --global GitVersion.Tool
   ```

2. **Check current version**:
   ```bash
   dotnet gitversion
   ```

3. **Build with version**:
   ```bash
   dotnet build --configuration Release
   ```

## CI/CD Integration

### GitHub Actions
- Automatically calculates version from commit messages
- Creates releases for master branch commits
- Uploads build artifacts with version tags

### Azure DevOps  
- Integrates with SonarCloud and Qodana
- Publishes versioned test results
- Creates versioned build artifacts

## Commit Message Guidelines

### DO ✅
- Use imperative mood: "add feature" not "added feature"
- Keep subject line under 50 characters
- Separate subject from body with blank line
- Explain **what** and **why**, not **how**
- Reference issues: "Fixes #123", "Closes #456"
- Use lowercase for type and description
- Include breaking change information

### DON'T ❌
- Don't capitalize subject line first letter
- Don't end subject line with period
- Don't commit without meaningful message
- Don't use past tense: "added" ❌ use "add" ✅
- Don't exceed 72 characters in body lines

## Examples

### Feature Addition
```
feat: implement generic FizzBuzz with custom predicates

This allows users to define their own rules for when to replace
numbers with custom strings, making the algorithm more flexible.

- Added FizzBuzz<T>(IEnumerable<T>, Predicate<T>, Predicate<T>)
- Maintained backward compatibility with existing methods  
- Added comprehensive unit tests for new functionality

Closes #42
```

### Bug Fix
```
fix: prevent null reference exception in FizzBuzz extension

The extension method now properly handles null input collections
by throwing ArgumentNullException with a descriptive message.

This addresses the issue where null inputs would cause runtime
exceptions during enumeration.

Fixes #15
```

### Breaking Change
```
feat!: migrate to async enumerable pattern

BREAKING CHANGE: All FizzBuzz extension methods now return 
IAsyncEnumerable<string> instead of IEnumerable<string> to 
support async/await scenarios and improve performance for 
large collections.

Migration guide:
- Replace `foreach (var item in collection.FizzBuzz())`  
- With `await foreach (var item in collection.FizzBuzz())`

Fixes #28
```

## Release Process

1. **Development**: Make commits following semantic convention
2. **Version Calculation**: GitVersion automatically calculates next version
3. **CI/CD**: Pipelines build with calculated version
4. **Release**: GitHub Actions creates release for master branch
5. **Artifacts**: Build artifacts tagged with semantic version

## Troubleshooting

### Common Issues

**Q: Version not incrementing**
A: Check commit message format. Use `feat:` for features, `fix:` for bugs.

**Q: Unexpected major version bump**
A: Check for `!` in type or `BREAKING CHANGE:` in footer.

**Q: GitVersion fails in CI**
A: Ensure `fetch-depth: 0` in checkout action for full git history.

### Validation Commands
```bash
# Check if commit follows convention
git log --oneline -1

# Test version calculation locally  
dotnet gitversion

# Validate commit message
echo "feat: add new feature" | grep -E "^(feat|fix|docs|style|refactor|perf|test|build|ci|chore)(\(.+\))?: .+"
```