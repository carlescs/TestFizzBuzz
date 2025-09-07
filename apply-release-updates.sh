#!/bin/bash

# Final script to apply the extended commit descriptions to GitHub releases
# This provides the exact commands needed to update each release

echo "=== GitHub Release Updates with Extended Commit Descriptions ==="
echo
echo "The following GitHub releases need to be updated with extended commit descriptions:"
echo

# Release data with IDs, tags, and file paths
declare -A releases=(
    ["245347957"]="v1.0.5:/tmp/release-updates/v1.0.5.md"
    ["245343239"]="v1.0.4:/tmp/release-updates/v1.0.4.md"
    ["245341307"]="v1.0.3:/tmp/release-updates/v1.0.3.md"
    ["245334000"]="v1.0.2:/tmp/release-updates/v1.0.2.md"
    ["245332038"]="v1.0.1:/tmp/release-updates/v1.0.1.md"
    ["245300868"]="1.0.0:/tmp/release-updates/1.0.0.md"
)

echo "GitHub API Update Commands:"
echo "=========================="
echo

for release_id in "${!releases[@]}"; do
    IFS=':' read -r tag_name file_path <<< "${releases[$release_id]}"
    
    echo "# Update release $tag_name (ID: $release_id)"
    echo "# Content preview:"
    head -10 "$file_path" | sed 's/^/#   /'
    echo "#   ... (see full content in $file_path)"
    echo
    echo "curl -X PATCH \\"
    echo "  -H \"Authorization: token \$GITHUB_TOKEN\" \\"
    echo "  -H \"Accept: application/vnd.github.v3+json\" \\"
    echo "  \"https://api.github.com/repos/carlescs/TestFizzBuzz/releases/$release_id\" \\"
    echo "  -d @- << 'EOF'"
    echo "{"
    echo "  \"body\": $(jq -Rs . < "$file_path")"
    echo "}"
    echo "EOF"
    echo
    echo "# Verify update:"
    echo "curl -H \"Accept: application/vnd.github.v3+json\" \\"
    echo "  \"https://api.github.com/repos/carlescs/TestFizzBuzz/releases/$release_id\" | jq -r '.body' | head -20"
    echo
    echo "---"
    echo
done

echo "Summary of Changes:"
echo "=================="
echo
for release_id in "${!releases[@]}"; do
    IFS=':' read -r tag_name file_path <<< "${releases[$release_id]}"
    line_count=$(wc -l < "$file_path")
    
    echo "  $tag_name: Enhanced with $line_count lines including extended commit descriptions"
done

echo
echo "Manual Update Instructions:"
echo "=========================="
echo "1. Get a GitHub Personal Access Token with 'repo' permissions"
echo "2. Set the token: export GITHUB_TOKEN='your_token_here'"
echo "3. Run the curl commands above for each release"
echo "4. Verify the updates by checking the release pages on GitHub"
echo
echo "Alternative Manual Update:"
echo "========================"
echo "1. Go to https://github.com/carlescs/TestFizzBuzz/releases"
echo "2. For each release, click 'Edit release'"
echo "3. Replace the release body with the content from the corresponding file:"
for release_id in "${!releases[@]}"; do
    IFS=':' read -r tag_name file_path <<< "${releases[$release_id]}"
    echo "   - $tag_name: Copy content from $file_path"
done
echo "4. Save each release"
echo
echo "Benefits of This Update:"
echo "======================="
echo "✅ Enhanced transparency - users can see detailed commit information"
echo "✅ Better context - full commit messages explain the 'why' behind changes"
echo "✅ Improved traceability - direct links to specific commits with hashes"
echo "✅ Consistent format - all releases now have the same enhanced structure"
echo "✅ Future releases - GitHub Actions workflow updated to automatically include extended descriptions"
echo
echo "The enhanced release notes provide both summary (existing) and detailed (new) views of changes,"
echo "giving users the level of information they need for each release."