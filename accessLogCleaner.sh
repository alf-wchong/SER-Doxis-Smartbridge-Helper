#!/bin/bash

# Check if a log file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <log_file>"
  exit 1
fi

log_file="$1"

# Check if the log file exists
if [ ! -f "$log_file" ]; then
  echo "Error: Log file '$log_file' not found."
  exit 1
fi

cleaned_log_file="cleanedLog.txt"
> "$cleaned_log_file" # Create/truncate the output file

# Use sed to remove everything to the left of the date in square brackets
sed 's/^.*\[\(.*\)\]/\1/' "$log_file" > "$cleaned_log_file"

echo "Cleaned log saved to '$cleaned_log_file'."

exit 0
