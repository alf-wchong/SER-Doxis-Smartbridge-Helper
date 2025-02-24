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

# Create the new log file (or overwrite if it exists)
new_log_file="HTTP_ACCESS_LOGGER_only.log"
> "$new_log_file"  # This truncates the file if it exists.

# Use grep to find lines with "HTTP_ACCESS_LOGGER" and append them to the new file, 
# while simultaneously filtering them out of the original file.
grep "HTTP_ACCESS_LOGGER" "$log_file" >> "$new_log_file"  # Extract and append
sed -i "/HTTP_ACCESS_LOGGER/d" "$log_file"  # Delete from original file

echo "Lines containing 'HTTP_ACCESS_LOGGER' have been moved to '$new_log_file'."

exit 0
