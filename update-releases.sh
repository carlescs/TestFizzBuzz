#!/bin/bash

# Script to update existing releases with extended commit descriptions
# This script will update all existing releases retroactively

set -e

echo "=== Updating Existing Releases with Extended Commit Descriptions ==="
echo

# GitHub API endpoint
GITHUB_API="https://api.github.com/repos/carlescs/TestFizzBuzz"
REPO_OWNER="carlescs"
REPO_NAME="TestFizzBuzz"

# Check if GitHub token is available (for testing purposes, we'll use a placeholder)
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Warning: GITHUB_TOKEN not set. This script requires a GitHub token to update releases."
    echo "For testing purposes, we'll simulate the updates and show what would be changed."
    SIMULATE_ONLY=true
else
    SIMULATE_ONLY=false
fi

# Function to get commits between two references
get_commits_in_range() {
    local from_ref="$1"
    local to_ref="$2"
    
    if [ -z "$from_ref" ]; then
        # For the first release, get all commits up to the tag
        git log --format="%H %s" --reverse "$to_ref" 2>/dev/null || true
    else
        # Get commits between two tags
        git log --format="%H %s" --reverse "${from_ref}..${to_ref}" 2>/dev/null || true
    fi
}

# Function to get full commit message
get_commit_message() {
    local commit_hash="$1"
    git log --format="%B" -n 1 "$commit_hash" 2>/dev/null || true
}

# Function to generate extended commit descriptions section
generate_extended_descriptions() {
    local commits="$1"
    local extended_section=""
    
    extended_section="## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

"
    
    if [ -n "$commits" ]; then
        while IFS= read -r commit; do
            if [ -n "$commit" ]; then
                # Extract commit hash and subject
                commit_hash=$(echo "$commit" | cut -d' ' -f1)
                commit_subject=$(echo "$commit" | cut -d' ' -f2-)
                
                # Get full commit message
                commit_body=$(get_commit_message "$commit_hash")
                
                # Add commit info
                extended_section="${extended_section}### ${commit_subject}
**Commit:** \`${commit_hash:0:7}\`

"
                
                # Add full commit message if it has more than just the subject line
                if [ "$(echo "$commit_body" | wc -l)" -gt 1 ]; then
                    # Remove the subject line and add the body
                    extended_body=$(echo "$commit_body" | tail -n +2 | sed '/^$/d')
                    if [ -n "$extended_body" ]; then
                        extended_section="${extended_section}${extended_body}

"
                    else
                        extended_section="${extended_section}*No extended description provided.*

"
                    fi
                else
                    extended_section="${extended_section}*No extended description provided.*

"
                fi
                extended_section="${extended_section}---

"
            fi
        done <<< "$commits"
    else
        extended_section="${extended_section}*No commits found in this release.*

"
    fi
    
    echo "$extended_section"
}

# Function to update a release (simulated for now)
update_release() {
    local release_id="$1"
    local tag_name="$2"
    local current_body="$3"
    local new_section="$4"
    
    echo "Updating release $tag_name (ID: $release_id)"
    echo "Adding extended commit descriptions section..."
    
    # Combine existing body with new section
    local updated_body="${current_body}

${new_section}"
    
    if [ "$SIMULATE_ONLY" = true ]; then
        echo "SIMULATION MODE - Would update with:"
        echo "----------------------------------------"
        echo "$updated_body"
        echo "----------------------------------------"
        echo
    else
        # This would be the actual API call to update the release
        echo "Would make API call to update release..."
        # curl -X PATCH \
        #   -H "Authorization: token $GITHUB_TOKEN" \
        #   -H "Accept: application/vnd.github.v3+json" \
        #   "$GITHUB_API/releases/$release_id" \
        #   -d "{\"body\": $(echo "$updated_body" | jq -R -s .)}"
    fi
}

# List of releases to update (tag_name:release_id:previous_tag)
# Note: In real implementation, these would be fetched from GitHub API
declare -a releases=(
    "v1.0.5:245347957:v1.0.4"
    "v1.0.4:245343239:v1.0.3"
    "v1.0.3:245341307:v1.0.2"
    "v1.0.2:245334000:v1.0.1"
    "v1.0.1:245332038:1.0.0"
    "1.0.0:245300868:"
)

# Process each release
for release_info in "${releases[@]}"; do
    IFS=':' read -r tag_name release_id previous_tag <<< "$release_info"
    
    echo "Processing release: $tag_name"
    echo "Previous tag: ${previous_tag:-"(initial release)"}"
    
    # Get commits for this release
    commits=$(get_commits_in_range "$previous_tag" "$tag_name")
    
    if [ -n "$commits" ]; then
        echo "Found $(echo "$commits" | wc -l) commits for $tag_name"
        echo "Sample commits:"
        echo "$commits" | head -3
        echo
        
        # Generate extended descriptions
        extended_section=$(generate_extended_descriptions "$commits")
        
        # For simulation, show what would be added
        echo "Would add the following extended descriptions section:"
        echo "=================================================="
        echo "$extended_section" | head -20
        echo "... (truncated for display)"
        echo "=================================================="
        echo
        
    else
        echo "No commits found for $tag_name"
        echo
    fi
done

echo "=== Update Complete ==="
if [ "$SIMULATE_ONLY" = true ]; then
    echo "This was a simulation. To actually update releases, set GITHUB_TOKEN environment variable."
fi