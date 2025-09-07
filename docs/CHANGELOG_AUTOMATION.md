# Automated Changelog and Release Notes

This document describes the automated changelog and release note generation process implemented for this project.

## Overview

The project automatically generates changelog entries and GitHub release notes based on conventional commits for every release. This process is integrated into the existing CI/CD pipeline and works alongside GitVersion for semantic versioning.

## How It Works

### 1. Commit Message Analysis
The system analyzes commit messages following the [Conventional Commits](https://www.conventionalcommits.org/) specification to categorize changes:

- **Features** (`feat:`): New functionality
- **Bug Fixes** (`fix:`): Bug corrections  
- **Documentation** (`docs:`): Documentation changes
- **Maintenance** (`chore:`, `build:`, `ci:`, `refactor:`, `style:`, `test:`, `perf:`): Maintenance tasks

### 2. Automated Process
When code is pushed to the `master` branch:

1. **Version Calculation**: GitVersion calculates the semantic version based on commit messages
2. **Changelog Generation**: The system generates changelog content from commits since the last release
3. **File Update**: `CHANGELOG.md` is automatically updated with the new version entry
4. **Commit**: Changes are committed back to the repository with `[skip-release]` flag
5. **Release Creation**: A GitHub release is created with the generated changelog as release notes

### 3. File Structure
- `CHANGELOG.md`: Automatically maintained changelog file
- `.github/workflows/dotnet.yml`: Contains the automation logic
- `docs/CHANGELOG_AUTOMATION.md`: This documentation file

## Usage Guidelines

### For Contributors
1. **Use Conventional Commits**: Always follow the conventional commit format:
   ```
   type(scope): description
   
   body (optional)
   
   footer (optional)
   ```

2. **Commit Types**: Use appropriate types to ensure proper categorization:
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation
   - `chore:`, `build:`, `ci:` for maintenance

### For Maintainers
- The changelog is automatically maintained - **do not edit manually**
- Releases are created automatically for master branch commits
- Use `[skip-release]` in commit message to prevent release creation
- The system preserves historical changelog entries

## Configuration

### GitVersion Integration
The system works alongside the existing GitVersion configuration:
- Version calculation remains with GitVersion
- Changelog generation uses the calculated version
- Both processes share the same conventional commit parsing

### Customization
To modify the changelog format or categories, edit the changelog generation logic in `.github/workflows/dotnet.yml`.

## Troubleshooting

### Common Issues

**Changelog not updating**
- Verify conventional commit format in recent commits
- Check GitHub Actions workflow logs
- Ensure `contents: write` permission is set in workflow

**Release not created**
- Check if commit message contains `[skip-release]`
- Verify workflow runs on master branch
- Review GitHub Actions permissions

**Missing commit categories**
- Verify commit messages follow conventional format
- Check that commit type is recognized in the workflow
- Review the git log parsing logic

### Manual Recovery
If the automated process fails:

1. Check the GitHub Actions workflow logs
2. Manually run the workflow if needed
3. In emergency, manually edit `CHANGELOG.md` and create release

## Examples

### Good Commit Messages
```
feat: add custom predicates support
fix: handle null input gracefully
docs: update README with examples
chore: update dependencies
```

### Generated Changelog Entry
```markdown
## [1.2.0] - 2024-12-19

### Features
- feat: add custom predicates support

### Bug Fixes  
- fix: handle null input gracefully

### Documentation
- docs: update README with examples

### Maintenance
- chore: update dependencies
```

## Benefits

- **Consistency**: Standardized changelog format across releases
- **Automation**: No manual maintenance required
- **Traceability**: Clear connection between commits and releases
- **Integration**: Seamless integration with existing GitVersion workflow
- **Compliance**: Follows Keep a Changelog and Semantic Versioning standards