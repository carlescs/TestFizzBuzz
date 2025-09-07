#!/bin/bash
# Test script for semantic versioning validation
# This script demonstrates semantic commit validation

echo "=== Semantic Commit Validation Test ==="
echo

# Test commit message format validation
echo "1. Testing commit message format validation:"
echo

valid_commits=(
    "feat: add new feature"
    "fix: resolve bug in extension method"
    "docs: update README with examples"
    "feat!: breaking change to API"
    "perf: improve algorithm performance"
    "test: add unit tests for edge cases"
    "style: format code according to standards"
    "refactor: restructure extension methods"
    "build: update dependencies"
    "ci: enhance GitHub Actions workflow"
    "chore: update project metadata"
)

invalid_commits=(
    "Add new feature"              # Missing type
    "feat add new feature"         # Missing colon  
    "FEAT: add new feature"        # Wrong case
    "feat: Add new feature"        # Capitalized description
    "feat: add new feature."       # Period at end
    "added new feature"            # Past tense, no type
)

# Regex pattern for conventional commits
pattern="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore)(\(.+\))?(!)?: [a-z].*[^.]$"

echo "✅ Valid commit messages:"
for commit in "${valid_commits[@]}"; do
    if echo "$commit" | grep -qE "$pattern"; then
        echo "  ✓ $commit"
    else
        echo "  ✗ $commit (should be valid but failed)"
    fi
done

echo
echo "❌ Invalid commit messages:"
for commit in "${invalid_commits[@]}"; do
    if echo "$commit" | grep -qE "$pattern"; then
        echo "  ✗ $commit (should be invalid but passed)"
    else
        echo "  ✓ $commit (correctly rejected)"
    fi
done

echo
echo "2. Testing version impact mapping:"
echo

declare -A version_impacts=(
    ["feat:"]="Minor version bump (0.1.0)"
    ["fix:"]="Patch version bump (0.0.1)"
    ["perf:"]="Patch version bump (0.0.1)"
    ["feat!:"]="Major version bump (1.0.0)"
    ["docs:"]="No version bump"
    ["style:"]="No version bump" 
    ["refactor:"]="No version bump"
    ["test:"]="No version bump"
    ["build:"]="No version bump"
    ["ci:"]="No version bump"
    ["chore:"]="No version bump"
)

for type in "${!version_impacts[@]}"; do
    echo "  $type → ${version_impacts[$type]}"
done

echo
echo "3. Files created for semantic versioning:"
echo "  ✓ .gitmessage (commit message template)"
echo "  ✓ GitVersion.yml (version calculation configuration)"
echo "  ✓ .github/copilot-instructions.md (updated with guidelines)"
echo "  ✓ docs/SEMANTIC_COMMITS.md (comprehensive documentation)"
echo "  ✓ .github/workflows/dotnet.yml (updated with GitVersion)"
echo "  ✓ azure-pipelines.yml (updated with semantic versioning)"

echo
echo "4. Next steps for testing semantic versioning:"
echo "  1. Create commits following semantic format"
echo "  2. Push to master branch"
echo "  3. Verify GitHub Actions calculates correct version"
echo "  4. Check that release is created with semantic version"
echo "  5. Confirm Azure DevOps pipeline uses versioned builds"

echo
echo "=== Semantic Versioning Setup Complete ==="