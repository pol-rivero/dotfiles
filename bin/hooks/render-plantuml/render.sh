#!/bin/bash

PLANTUML_JAR_PATH="$(dirname "$0")/plantuml.jar"

IGNORE_PREFIX="_"

usage_and_exit() {
  exit_code="${1:-1}"
  echo "Usage: $0 <directory_or_file> [<directory_or_file> ...]"
  echo "Specify either a directory containing .plantuml files or a single .plantuml file."
  exit "$exit_code"
}


# Function to convert a single .plantuml file to SVG
convert_to_svg() {
  local input_file="$1"
  local base_name="${input_file%.plantuml}"
  local output_file="$base_name.svg"
  local base_name_without_path="${base_name##*/}"

  if [[ "$base_name_without_path" == "$IGNORE_PREFIX"* ]]; then
    echo "Ignoring $input_file..."
    return
  fi
  
  echo "Converting $input_file..."
  java -jar "$PLANTUML_JAR_PATH" -tsvg -p < "$input_file" > "$output_file-tmp"
  mv "$output_file-tmp" "$output_file"

  if [ $? -ne 0 ]; then
    # Red color
    tput setaf 1
    echo "Error converting $input_file"
    tput sgr0
    exit 1
  else
    # Green color
    tput setaf 2
    echo "File $output_file created successfully."
    tput sgr0
  fi
}


process_arg() {
  local arg="$1"
  
  if [ -d "$arg" ]; then
    # If it's a directory, convert all .plantuml files in the directory to SVG
    for plantuml_file in "$arg"/*.plantuml; do
      if [ -f "$plantuml_file" ]; then
        convert_to_svg "$plantuml_file" &
      fi
    done
  elif [ -f "$arg" ] && [[ "$arg" == *.plantuml ]]; then
    # If it's a single .plantuml file, convert it to SVG
    convert_to_svg "$arg" &
  elif [ "$arg" == "-h" ] || [ "$arg" == "--help" ]; then
    usage_and_exit 0
  else
    echo "Invalid argument: $arg"
    usage_and_exit
  fi
}


# Check if there are any arguments provided
if [ $# -eq 0 ]; then
  usage_and_exit
fi

# Process each argument in parallel
for arg in "$@"; do
  process_arg "$arg"
done

wait

echo "Done."
