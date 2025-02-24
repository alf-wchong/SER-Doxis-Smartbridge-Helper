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

cleaned_log_file="cleanedLogNoChecks.txt"
> "$cleaned_log_file" # Create/truncate the output file

# Use awk to filter and replace lines
awk '
  /GET \/sbsalesforce\/healthz\/(live|ready)/ {
    if (!in_healthcheck_block) {
      print "-----"
      in_healthcheck_block = 1
    }
    next  # Skip printing the original healthcheck line
  }
  !/GET \/sbsalesforce\/healthz\/(live|ready)/ {
    print
    in_healthcheck_block = 0
  }
' "$log_file" > "$cleaned_log_file"

echo "Cleaned log (without health checks) saved to '$cleaned_log_file'."

exit 0
