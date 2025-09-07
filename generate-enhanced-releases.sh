#!/bin/bash

# Complete script to update all releases with extended commit descriptions
# Uses the commit data we have from the repository

set -e

echo "=== Creating Updated Release Notes with Extended Commit Descriptions ==="
echo

# Function to create extended descriptions for v1.0.5 (commits: 48e0eff, b4af9f4, 34e625b)
create_v1_0_5() {
    cat << 'EOF'
Release v1.0.5 generated from commit 48e0effffb258ee0fb65473ca8d7b46e1d455395.

## Changes

### 🚀 Features
- feat(FizzBuzzExtensions): enhance FizzBuzz operations
- feat(tests, extensions): add custom labels for FizzBuzz

## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

### Merge pull request #65 from carlescs/feature/param-labels
**Commit:** `48e0eff` by Carles Company Soler on 2025-09-07T12:22:32Z

Add custom labels for Fizz and Buzz

---

### feat(FizzBuzzExtensions): enhance FizzBuzz operations
**Commit:** `b4af9f4` by Carles Company Soler on 2025-09-07T12:18:55Z

Updated the `FizzBuzzExtensions` class to allow explicit labels for "Fizz" and "Buzz" in FizzBuzz operations. Introduced a new overload of the `FizzBuzz` method that utilizes standard divisibility predicates (3 and 5) without requiring labels.

Documentation comments have been revised to clarify the purpose and parameters of each method. ✨

---

### feat(tests, extensions): add custom labels for FizzBuzz
**Commit:** `34e625b` by Carles Company Soler on 2025-09-07T11:08:51Z

Added new unit tests for FizzBuzz with custom labels in `FizzBuzzTests.cs`.
The `FizzBuzzExtensions` class in `FizzBuzzExtensions.cs` has been updated to support optional parameters for custom fizz and buzz labels, enhancing flexibility in label usage.

✨ New tests: `FizzBuzz_IntCustomLabels` and `FizzBuzz_GenericCustomLabels`.
🔧 Updated method signatures to include `fizzLabel` and `buzzLabel`.

---

**Full Changelog**: [View all commits](https://github.com/carlescs/TestFizzBuzz/commits/v1.0.5)
EOF
}

# Function to create extended descriptions for v1.0.4 (commits: 53f077c, d3bd408, 16aadd8, 6f2edee)
create_v1_0_4() {
    cat << 'EOF'
Release v1.0.4 generated from commit 53f077c580a75fb5e49aebf3c9ea8498deba05ab.

## Changes

### 🚀 Features
- feat: improve release notes with detailed change documentation
- feat!: remove automatic CHANGELOG.md generation and simplify releases

### 📚 Documentation
- docs: update README to remove changelog automation references

## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

### Merge pull request #64 from carlescs/copilot/fix-63
**Commit:** `53f077c` by Carles Company Soler on 2025-09-07T10:49:14Z

Remove automatic CHANGELOG.md generation; add detailed changes to GitHub release notes

---

### feat: improve release notes with detailed change documentation
**Commit:** `d3bd408` by copilot-swe-agent[bot] on 2025-09-07T10:46:01Z

- Add automatic generation of categorized release notes
- Include sections for Features, Bug Fixes, Documentation, and Maintenance changes
- Use conventional commit patterns to categorize changes automatically
- Add emoji icons for better readability (🚀 🐛 📚 🔧)
- Preserve full changelog link for detailed commit history
- Maintain simple, clean format while providing specific change details

Example output:
## Changes
### 🚀 Features
- feat!: remove automatic CHANGELOG.md generation and simplify releases
### 📚 Documentation
- docs: update README to remove changelog automation references

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---

### docs: update README to remove changelog automation references
**Commit:** `16aadd8` by copilot-swe-agent[bot] on 2025-09-07T10:37:19Z

- Remove link to deleted CHANGELOG_AUTOMATION.md documentation
- Update CI/CD description to reflect simplified release process
- Fix release note link to use more reliable commit history view

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---

### feat!: remove automatic CHANGELOG.md generation and simplify releases
**Commit:** `6f2edee` by copilot-swe-agent[bot] on 2025-09-07T10:35:45Z

BREAKING CHANGE: removed automatic CHANGELOG.md file generation
- Remove CHANGELOG.md file from repository
- Remove docs/CHANGELOG_AUTOMATION.md documentation
- Remove test-changelog-pr.md test file
- Simplify GitHub Actions workflow by removing changelog generation logic
- Update release creation to use concise release notes without changelog
- Keep semantic versioning and GitVersion functionality intact

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---

**Full Changelog**: [View all commits](https://github.com/carlescs/TestFizzBuzz/commits/v1.0.4)
EOF
}

# Function to create extended descriptions for v1.0.3 (commits: 5454184, 3138b8e, da4f781, etc.)
create_v1_0_3() {
    cat << 'EOF'
## Version 1.0.3

**Full Semantic Version:** 1.0.3+8
**Assembly Version:** 1.0.3.0

### Changes

### Features
- No new features

### Bug Fixes
- No bug fixes

### Documentation
- docs: update changelog for v1.0.3-PullRequest0061.2 [skip-release]

### Maintenance
- chore(.gitignore): update ignore patterns
- test(FizzBuzzTests): enhance test coverage and structure

## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

### Merge pull request #61 from carlescs/feature/improve-tests
**Commit:** `5454184` by Carles Company Soler on 2025-09-07T10:16:34Z

test(FizzBuzzTests): enhance test coverage and structure

---

### docs: update changelog for v1.0.3-PullRequest0061.6 [skip-release]
**Commit:** `3138b8e` by GitHub Action on 2025-09-07T10:12:20Z

*No extended description provided.*

---

### Merge 3e74edd22ed89412610c7b8acf442855683ffcb5 into 79c336708e728205038dfb96edd997203751a076
**Commit:** `da4f781` by Carles Company Soler on 2025-09-07T10:11:50Z

*No extended description provided.*

---

### chore(.gitignore): update ignore patterns
**Commit:** `46354f7` by Carles Company Soler on 2025-09-07T10:11:31Z

Updated the `.gitignore` file to include additional entries for ignoring specific Visual Studio and test result directories and files.

🗑️ Removed the `coverage.cobertura.xml` file, which contained coverage data for the `TestFizzBuzz` project, including line and branch coverage details for methods in the `FizzBuzzExtensions` class.

---

### test(FizzBuzzTests): enhance test coverage and structure
**Commit:** `875202` by Carles Company Soler on 2025-09-07T10:08:13Z

Improved the `FizzBuzzTests` class by adding new tests and refactoring existing ones.
- 🆕 Added `FizzBuzz_IntRegression` to validate integer cases.
- 🔄 Updated `_fizzbuzzStrings` initialization in the constructor.
- 🧪 Enhanced `FizzBuzzTestSpecialCasesStrings` with an additional test case.
- 🧪 Introduced tests for negative numbers, zero behavior, and custom predicates.
- ✨ Improved code readability and structure.
- 📊 Added a new coverage report in `coverage.cobertura.xml` showing full line and branch coverage.

---
EOF
}

# Function to create extended descriptions for v1.0.2 (commits: 79c3367, 579a9f0, 9bb6f80, etc.)
create_v1_0_2() {
    cat << 'EOF'
## Version 1.0.2

**Full Semantic Version:** 1.0.2+8
**Assembly Version:** 1.0.2.0

### Changes

### Dependencies
- Updated NuGet packages to latest versions:
  - `coverlet.collector`: 6.0.2 → 6.0.4
  - `Microsoft.NET.Test.Sdk`: 17.12.0 → 17.14.1  
  - `xunit`: 2.9.2 → 2.9.3
  - `xunit.runner.console`: 2.9.2 → 2.9.3
  - `xunit.runner.visualstudio`: 2.8.2 → 3.1.4

### Notes
- No breaking changes introduced
- All existing tests continue to pass
- Application functionality remains unchanged

## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

### Merge pull request #60 from carlescs/copilot/fix-59
**Commit:** `79c3367` by Carles Company Soler on 2025-09-07T07:50:01Z

ci: move changelog generation from master to PR workflow

---

### docs: update documentation for PR-based changelog workflow
**Commit:** `579a9f0` by copilot-swe-agent[bot] on 2025-09-07T07:44:39Z

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---

### ci: move changelog generation from master to PR workflow
**Commit:** `9bb6f80` by copilot-swe-agent[bot] on 2025-09-07T07:43:33Z

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---
EOF
}

# Function to create extended descriptions for v1.0.1 
create_v1_0_1() {
    cat << 'EOF'
## Version 1.0.1

**Full Semantic Version:** 1.0.1+6
**Assembly Version:** 1.0.1.0

### Changes
This release was automatically generated from commit bb2c9ea1f59613bd42aa3e19b3b2de1137dcd010.

## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

### Merge pull request #56 from carlescs/copilot/fix-55
**Commit:** `bb2c9ea` by Carles Company Soler on 2025-09-07T07:08:38Z

feat: implement semantic commits and automated semantic versioning

---

### fix: update GitHub Actions workflow with modern GitVersion setup
**Commit:** `034a871` by copilot-swe-agent[bot] on 2025-09-06T20:40:55Z

- Update GitVersion actions to stable v1.1.1 versions
- Move .NET setup before GitVersion to ensure proper environment
- Simplify GitVersion configuration with ContinuousDelivery mode
- Replace deprecated actions/create-release with softprops/action-gh-release
- Remove problematic GitVersion flags that caused CI issues
- Tested build process works correctly in .NET 9.0 container

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---

### feat: implement semantic commits and automated semantic versioning
**Commit:** `c9dcf4d` by copilot-swe-agent[bot] on 2025-09-06T20:12:26Z

This commit establishes comprehensive semantic commit and versioning infrastructure:

## Semantic Commit Guidelines
- Added detailed semantic commit guidelines to .github/copilot-instructions.md
- Created commit message template (.gitmessage) with examples and guidelines
- Included conventional commit types (feat, fix, docs, etc.) with version impact

## Automated Semantic Versioning Setup
- Configured GitVersion.yml for automated version calculation from commit messages
- Updated GitHub Actions workflow to use GitVersion and create releases
- Enhanced Azure DevOps pipeline with semantic versioning integration
- Added fallback versioning in project files for robust builds

## Documentation and Examples
- Created comprehensive docs/SEMANTIC_COMMITS.md with detailed guidance
- Updated README.md with semantic commit overview and development instructions
- Included practical examples for all commit types and breaking changes

## CI/CD Integration
- GitHub Actions now calculates versions, builds with semantic versions, and creates releases
- Azure DevOps pipeline integrates versioning with SonarCloud and test reporting
- Both pipelines support versioned artifacts and automated release processes

## Version Strategy
- Major: Breaking changes (feat! or BREAKING CHANGE:)
- Minor: New features (feat:)
- Patch: Bug fixes (fix:) and performance improvements (perf:)
- No bump: Documentation, style, test, chore, etc.

The project now supports fully automated semantic versioning based on
conventional commit messages, enabling developers to control version
bumps through their commit message format.

Co-authored-by: carlescs <778738+carlescs@users.noreply.github.com>

---
EOF
}

# Function to create extended descriptions for 1.0.0 (initial release)
create_1_0_0() {
    cat << 'EOF'


## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

### Initial release of TestFizzBuzz
**Commit:** `2e569e3` by Carles Company Soler on 2025-09-06T19:55:10Z

This is the initial release of the TestFizzBuzz .NET 9.0 console application featuring:
- Generic FizzBuzz algorithm with extension methods
- Comprehensive unit testing with xUnit
- CI/CD integration with GitHub Actions and Azure DevOps
- .NET 9.0 target framework with modern development practices

---
EOF
}

# Generate all updated release notes
echo "Generating updated release notes for all releases..."

mkdir -p /tmp/release-updates

create_v1_0_5 > /tmp/release-updates/v1.0.5.md
create_v1_0_4 > /tmp/release-updates/v1.0.4.md
create_v1_0_3 > /tmp/release-updates/v1.0.3.md
create_v1_0_2 > /tmp/release-updates/v1.0.2.md
create_v1_0_1 > /tmp/release-updates/v1.0.1.md
create_1_0_0 > /tmp/release-updates/1.0.0.md

echo "Generated release notes for:"
echo "  - v1.0.5: $(wc -l < /tmp/release-updates/v1.0.5.md) lines"
echo "  - v1.0.4: $(wc -l < /tmp/release-updates/v1.0.4.md) lines" 
echo "  - v1.0.3: $(wc -l < /tmp/release-updates/v1.0.3.md) lines"
echo "  - v1.0.2: $(wc -l < /tmp/release-updates/v1.0.2.md) lines"
echo "  - v1.0.1: $(wc -l < /tmp/release-updates/v1.0.1.md) lines"
echo "  - 1.0.0: $(wc -l < /tmp/release-updates/1.0.0.md) lines"
echo
echo "Release notes are ready in /tmp/release-updates/"
echo
echo "To view a release note:"
echo "  cat /tmp/release-updates/v1.0.5.md"
echo
echo "These can be used to update the GitHub releases manually or via API."