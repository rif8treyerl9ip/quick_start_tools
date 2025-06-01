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
# WEB_ASSETS - list of web asset extensions to exclude
#
# Version: 1.0

BASE_DIR=".repo-splitter"
OUTPUT_DIR="${BASE_DIR}/output"

LINES_PER_FILE=1000
OUTPUT_FILE="all.txt"

# 削除対象の定義
DELETE_FILES=(
    "csv" "tsv"
    "png" "jpg" "jpeg" "svg" "pu" "drawio"
    "exe" "dll" "so" "dylib" "class"
    "jar" "war" "ear" "zip" "tar" "gz" "rar" "7z"
    # web(html/css)
    "html" "css" "map"
    "gif" "ico"
    "woff" "woff2" "ttf" "eot" "svg"
    "bin" "dat" "db" "sqlite"
    "ipynb" "env"
)

DELETE_DIRS=(
    ".venv"
    ".vscode"
    "__pycache__"
    ".git"
    ".github"
    ".ruff_cache"
    "node_modules"
    "build"
    "dist"
    "logs"
    "target"
    "warehouse"
)

DELETE_AIRFLOW=(
    "airflow.cfg"
    "airflow.db"
    "webserver_config.py"
    "airflow-webserver.pid"
)

prepare_directories() {
    mkdir -p "${OUTPUT_DIR}"
}

get_repo_name() {
    local repo_url=$1
    basename "$repo_url" .git
}

clone_repository() {
    local repo_url=$1
    local repo_name=$2
    echo "Clone repository: $repo_url"
    echo -e "Destination: $BASE_DIR/$repo_name\n"
    git clone "$repo_url" "$BASE_DIR/$repo_name"
}

copy_directory() {
    local repo_path=$1
    echo "Copy directory: $repo_path"
    echo -e "Destination: $BASE_DIR/$repo_name\n"
    cp -r "$repo_path" "$BASE_DIR/$repo_name"
    
    delete_unwanted_files "$BASE_DIR/$repo_name"
}

delete_unwanted_files() {
    local repo_path=$1
    echo "repo_path: $repo_path"
    
    for ext in "${DELETE_FILES[@]}"; do
        find "$repo_path" -type f -name "*.$ext" -delete
    done
    
    for dir in "${DELETE_DIRS[@]}"; do
        find "$repo_path" -type d -name "$dir" -prune -exec rm -rf {} +
    done
    for file in "${DELETE_AIRFLOW[@]}"; do
        find "$repo_path" -type f -name "$file" -delete
    done
}

extract_text_files() {
    local repo_path=$1
    local output_path="${OUTPUT_DIR}/${OUTPUT_FILE}"
    touch "$output_path"
    find "$repo_path" -type f \
        ! -path "*/\.*" \
        ! -path "*/build/*" \
        ! -path "*/dist/*" \
        ! -path "*/node_modules/*" \
        -exec file {} \; | grep "text" | cut -d: -f1 | while read -r file; do
        echo "=== ${file#${BASE_DIR}/} ===" >> "$output_path"
        cat "$file" >> "$output_path"
        echo -e "\n\n" >> "$output_path"
    done
    find "$repo_path" -type f \
        ! -path "*/\.*" \
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
clone_repo=${2:-""}

main() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <repository_url>"
        exit 1
    fi
    
    local repo_url=$1
    rm -rf .repo-splitter
    prepare_directories
    
    local repo_name="$(get_repo_name "$repo_url")"
    local repo_path="${BASE_DIR}/${repo_name}"

    if [ $clone_repo ]; then
        clone_repository "$repo_url" "$repo_name"
    else
        copy_directory "$repo_url" "$repo_name"
    fi

    extract_text_files "$repo_path" "$exclude_pattern"
    
    split_files
    
    echo "============================"
    echo "repo_name: $repo_name"
    echo "repo_path: $repo_path"
    echo -e "\nProcessing completed:"
    echo "Split files: ${OUTPUT_DIR}/content_*.txt"
    echo "all.txt row: $(cat "${OUTPUT_DIR}/${OUTPUT_FILE}" | wc -l)"
    echo "============================"
}

main "$@"