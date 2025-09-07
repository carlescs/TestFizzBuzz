#!/bin/bash

# Script to update existing GitHub releases with extended commit descriptions
# This script uses the GitHub API to retroactively update all releases

set -e

echo "=== Updating All Existing Releases with Extended Commit Descriptions ==="
echo

# Configuration
REPO_OWNER="carlescs"
REPO_NAME="TestFizzBuzz"
GITHUB_API_BASE="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME"

# Function to add extended commit descriptions to release body
add_extended_descriptions() {
    local current_body="$1"
    local commits_json="$2"
    
    # Start building the extended descriptions section
    local extended_section="

## Extended Commit Descriptions

This section provides detailed commit information for all changes included in this release.

"
    
    # Parse commits and add detailed descriptions
    while IFS= read -r commit; do
        if [ -n "$commit" ]; then
            local sha=$(echo "$commit" | jq -r '.sha')
            local short_sha="${sha:0:7}"
            local subject=$(echo "$commit" | jq -r '.commit.message' | head -n1)
            local full_message=$(echo "$commit" | jq -r '.commit.message')
            local author_name=$(echo "$commit" | jq -r '.commit.author.name')
            local commit_date=$(echo "$commit" | jq -r '.commit.author.date')
            
            # Add commit header
            extended_section="${extended_section}### ${subject}
**Commit:** \`${short_sha}\` by ${author_name} on ${commit_date}

"
            
            # Add extended description if available
            local body_lines=$(echo "$full_message" | wc -l)
            if [ "$body_lines" -gt 1 ]; then
                local extended_body=$(echo "$full_message" | tail -n +2 | sed '/^$/d')
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
    done <<< "$(echo "$commits_json" | jq -c '.[]')"
    
    # Combine original body with extended descriptions
    echo "${current_body}${extended_section}"
}

# Function to get commits between two tags
get_commits_between_tags() {
    local from_tag="$1"
    local to_tag="$2"
    local comparison_url
    
    if [ -z "$from_tag" ]; then
        # For the first release, get commits up to the tag
        comparison_url="${GITHUB_API_BASE}/commits?sha=${to_tag}&per_page=100"
    else
        # Get comparison between tags
        comparison_url="${GITHUB_API_BASE}/compare/${from_tag}...${to_tag}"
    fi
    
    echo "Fetching commits from: $comparison_url" >&2
    
    if [ -z "$from_tag" ]; then
        curl -s -H "Accept: application/vnd.github.v3+json" "$comparison_url" | jq '.[]'
    else
        curl -s -H "Accept: application/vnd.github.v3+json" "$comparison_url" | jq '.commits[]'
    fi
}

# Function to update a GitHub release
update_github_release() {
    local release_id="$1"
    local new_body="$2"
    
    # Escape the body for JSON
    local escaped_body=$(echo "$new_body" | jq -R -s .)
    
    curl -s -X PATCH \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token ${GITHUB_TOKEN:-fake-token}" \
        "$GITHUB_API_BASE/releases/$release_id" \
        -d "{\"body\": $escaped_body}" > /dev/null
    
    echo "Updated release $release_id"
}

# Define releases to update (in reverse chronological order for easier processing)
declare -A releases
releases[245347957]="v1.0.5:v1.0.4"   # v1.0.5 since v1.0.4
releases[245343239]="v1.0.4:v1.0.3"   # v1.0.4 since v1.0.3
releases[245341307]="v1.0.3:v1.0.2"   # v1.0.3 since v1.0.2
releases[245334000]="v1.0.2:v1.0.1"   # v1.0.2 since v1.0.1
releases[245332038]="v1.0.1:1.0.0"    # v1.0.1 since 1.0.0
releases[245300868]="1.0.0:"          # 1.0.0 (initial release)

# Process each release
for release_id in "${!releases[@]}"; do
    IFS=':' read -r to_tag from_tag <<< "${releases[$release_id]}"
    
    echo "Processing release ID $release_id: $to_tag"
    echo "Changes since: ${from_tag:-'initial commit'}"
    
    # Get the current release info
    echo "Fetching current release information..."
    current_release=$(curl -s -H "Accept: application/vnd.github.v3+json" "$GITHUB_API_BASE/releases/$release_id")
    current_body=$(echo "$current_release" | jq -r '.body')
    
    # Check if already has extended descriptions
    if echo "$current_body" | grep -q "## Extended Commit Descriptions"; then
        echo "Release $to_tag already has extended commit descriptions. Skipping."
        echo
        continue
    fi
    
    # Get commits for this release
    echo "Fetching commits for release range..."
    commits_json=$(get_commits_between_tags "$from_tag" "$to_tag")
    
    if [ -z "$commits_json" ] || [ "$commits_json" = "null" ]; then
        echo "No commits found for release $to_tag"
        echo
        continue
    fi
    
    commit_count=$(echo "$commits_json" | jq -s length)
    echo "Found $commit_count commits"
    
    # Generate updated release body
    echo "Generating updated release notes..."
    updated_body=$(add_extended_descriptions "$current_body" "$(echo "$commits_json" | jq -s .)")
    
    # Check if we're in simulation mode
    if [ -z "$GITHUB_TOKEN" ] || [ "$GITHUB_TOKEN" = "fake-token" ]; then
        echo "SIMULATION MODE - Would update release $to_tag with:"
        echo "=========================="
        echo "$updated_body" | head -30
        echo "... (truncated for display)"
        echo "=========================="
    else
        echo "Updating GitHub release $to_tag..."
        update_github_release "$release_id" "$updated_body"
        echo "Successfully updated release $to_tag"
    fi
    
    echo
done

echo "=== Update Complete ==="
if [ -z "$GITHUB_TOKEN" ] || [ "$GITHUB_TOKEN" = "fake-token" ]; then
    echo
    echo "This was a simulation. To actually update releases:"
    echo "1. Set GITHUB_TOKEN environment variable with a personal access token"
    echo "2. Ensure the token has 'repo' scope permissions"
    echo "3. Run the script again"
fi