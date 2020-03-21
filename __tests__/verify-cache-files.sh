#!/bin/sh

# Validate args
prefix="$1"
if [ -z "$prefix" ]; then
  echo "Must supply prefix argument"
  exit 1
fi

# Sanity check GITHUB_RUN_ID defined
if [ -z "$GITHUB_RUN_ID" ]; then
  echo "GITHUB_RUN_ID not defined"
  exit 1
fi

# Verify file exists
file="test-cache/test-file.txt"
echo "Checking for $file"
if [ ! -e $file ]; then
  echo "File does not exist"
  exit 1
fi

# Verify file content
content="$(cat $file)"
printf "File content:\n%s\n" "$content"
if ! echo "$content" | grep --fixed-strings "$prefix $GITHUB_RUN_ID"; then
  echo "Unexpected file content"
  exit 1
fi
