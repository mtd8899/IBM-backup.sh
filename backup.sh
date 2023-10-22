#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print an error message and exit
if [[ $# != 2 ]]; then
  echo "Usage: backup.sh target_directory_name destination_directory_name"
  exit 1
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Invalid directory path provided"
  exit 1
fi

# [TASK 1]
targetDirectory="$1"
destinationDirectory="$2"

# [TASK 2]
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd "$destinationDirectory"
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$origAbsPath"

# [TASK 8]
yesterdayTS=$((currentTS - 24 * 60 * 60))

declare -a toBackup

# [TASK 9]
for file in "$targetDirectory"/*; do
  if [[ -f "$file" ]]; then
    last_mod=$(date -r "$file" +%s)
    # [TASK 10]
    if ((last_mod > yesterdayTS)); then
      toBackup+=("$file")
      # [TASK 11]
    fi
  fi
done

# [TASK 12]
tar -czvf "$backupFileName" "${toBackup[@]}"

# [TASK 13]
mv "$backupFileName" "$destDirAbsPath"

# Congratulations! You completed the final project for this course!
