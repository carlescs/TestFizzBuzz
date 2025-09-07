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
When a pull request is created targeting the `master` branch:

1. **Version Calculation**: GitVersion calculates the semantic version based on commit messages
2. **Changelog Generation**: The system generates changelog content from commits since the last release
3. **File Update**: `CHANGELOG.md` is automatically updated with the new version entry
4. **PR Commit**: Changes are committed to the PR branch with `[skip-release]` flag
5. **Release Creation**: When merged to master, a GitHub release is created with the generated changelog as release notes

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

## Integration with Existing Workflows

### GitHub Actions Integration
The automated changelog generation is integrated into the existing `.github/workflows/dotnet.yml` workflow:

1. **Existing Steps Preserved**: All existing build, test, and GitVersion steps remain unchanged
2. **New Steps Added**: Changelog generation occurs during pull request workflow for PRs targeting master
3. **PR Workflow**: Changelog updates run on pull requests targeting master, not on master itself
4. **Skip Mechanism**: Commits with `[skip-release]` bypass changelog generation

### Azure DevOps Compatibility  
The automation doesn't interfere with the existing `azure-pipelines.yml`:
- Azure pipeline continues to work with SonarCloud and Qodana analysis
- Version calculation remains consistent between platforms
- No additional dependencies or configurations required

## Configuration

### GitVersion Integration
The system works alongside the existing GitVersion configuration:
- Version calculation remains with GitVersion
- Changelog generation uses the calculated version
- Both processes share the same conventional commit parsing

### Workflow Customization
To modify the changelog format or categories, edit the changelog generation logic in `.github/workflows/dotnet.yml`:

- **Commit Categories**: Modify the `git log --grep` patterns to change which commit types are included
- **Section Headers**: Update the section titles (Features, Bug Fixes, etc.)
- **Formatting**: Adjust the sed commands to change how commits are formatted in the changelog
- **Date Format**: Modify the `date +%Y-%m-%d` format in the changelog header

### Repository Settings
Ensure the following repository settings for proper operation:

- **Branch Protection**: Configure master branch protection as desired - changelog generation works with protected branches
- **GitHub Actions Permissions**: Verify `contents: write` permission is granted
- **Pull Request Workflow**: Ensure PR workflow can commit to PR branches
- **Conventional Commits**: Team should follow conventional commit guidelines

## Troubleshooting

### Common Issues

**Changelog not updating**
- Verify conventional commit format in recent commits
- Check GitHub Actions workflow logs for PR workflows
- Ensure `contents: write` permission is set in workflow
- Verify PR is targeting master branch

**Release not created**
- Check if commit message contains `[skip-release]`
- Verify workflow runs on master branch after PR merge
- Review GitHub Actions permissions
- Ensure CHANGELOG.md was properly committed in the PR

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