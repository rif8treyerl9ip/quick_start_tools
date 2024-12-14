#!/bin/bash

#!/bin/bash
#
# Script to clone a Git repository, extract and split text files.
# Collect text files while excluding binary files, web assets, and specific directories,
# and split them at a specified number of lines.
#
# Typical usage:
# ./repo-splitter.sh https://github.com/username/repo.git
#
# Globals:
# BASE_DIR - working base directory (.repo-splitter)
# OUTPUT_DIR - output file save directory (${BASE_DIR}/output)
# LINES_PER_FILE - number of lines per file when splitting (1000 lines)
# OUTPUT_FILE - name of merged file (all.txt)
# BINARY_EXTENSIONS - list of binary file extensions to exclude
# WEB_ASSETS - list of web asset extensions to exclude
# EXCLUDED_DIRS - list of directory patterns to exclude
#
# Version: 1.0

BASE_DIR=".repo-splitter"
OUTPUT_DIR="${BASE_DIR}/output"

LINES_PER_FILE=1000
OUTPUT_FILE="all.txt"

BINARY_EXTENSIONS=(
    "png" "jpg" "jpeg" "gif" "ico"
    "exe" "dll" "so" "dylib" "class"
    "jar" "war" "ear" "zip" "tar" "gz" "rar" "7z"
    "bin" "dat" "db" "sqlite"
)

WEB_ASSETS=(
    "html" "css" "map"
    "woff" "woff2" "ttf" "eot" "svg"
)

EXCLUDED_DIRS=(
    "*/\.*"
    "*/build/*"
    "*/dist/*"
    "*/node_modules/*"
    "*/__pycache__/*"
)

prepare_directories() {
    mkdir -p "${OUTPUT_DIR}"
}

get_repo_name() {
    local repo_url=$1
    basename "$repo_url" .git
}

build_exclude_pattern() {
    local pattern=""
    for ext in "${BINARY_EXTENSIONS[@]}" "${WEB_ASSETS[@]}"; do
        pattern="${pattern}|${ext}"
    done
    pattern=".*\.\(${pattern:1}\)"
    echo "$pattern"
}

clone_repository() {
    local repo_url=$1
    local repo_name=$2
    echo "Clone repository: $repo_url"
    echo -e "Destination: $BASE_DIR/$repo_name\n"
    git clone "$repo_url" "$BASE_DIR/$repo_name"
}


extract_text_files() {
    local repo_path=$1
    local exclude_pattern=$2
    local output_path="${OUTPUT_DIR}/${OUTPUT_FILE}"
    touch "$output_path"

    find "$repo_path" -type f \
        ! -path "*/\.*" \
        ! -path "*/build/*" \
        ! -path "*/dist/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/__pycache__/*" \
        ! -name "$exclude_pattern" \
        -exec file {} \; | grep "text" | cut -d: -f1 | while read -r file; do
        echo "=== $file ===" >> "$output_path"
        cat "$file" >> "$output_path"
        echo -e "\n\n" >> "$output_path"
    done
    find "$repo_path" -type f \
        ! -path "*/\.*" \
        ! -path "*/build/*" \
        ! -path "*/dist/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/__pycache__/*" \
        ! -name "$exclude_pattern" \
        -exec file {} \; | grep "text" | cut -d: -f1 | while read -r file; do
        echo "$file" >> "${OUTPUT_DIR}/file_list.txt"
    done
}

split_files() {
    cd "${OUTPUT_DIR}"
    
    echo "Split file into ${LINES_PER_FILE} lines..."
    split -l "$LINES_PER_FILE" "${OUTPUT_FILE}" content_
    
    for file in content_*; do
        mv "$file" "${file}.txt"
    done
    
    cd - > /dev/null
}

main() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <repository_url>"
        exit 1
    fi
    
    local repo_url=$1
    
    prepare_directories
    
    local exclude_pattern=$(build_exclude_pattern)
    local repo_name="$(get_repo_name "$repo_url")"
    local repo_path="${BASE_DIR}/${repo_name}"

    clone_repository "$repo_url" "$repo_name"

    extract_text_files "$repo_path" "$exclude_pattern"
    
    split_files
    
    echo "============================"
    echo "repo_name: $repo_name"
    echo "repo_path: $repo_path"
    echo "exclude_pattern: $exclude_pattern"
    echo -e "\nProcessing completed:"
    echo "Split files: ${OUTPUT_DIR}/content_*.txt"
    echo "Reset command: rm -rf .repo-splitter"
    echo "all.txt row: $(cat ${OUTPUT_DIR}/${OUTPUT_FILE} | wc -l)"
    echo "============================"
}

main "$@"