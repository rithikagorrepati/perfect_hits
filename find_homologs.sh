#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Error: Missing files!"
  echo "Usage: ./find_perfect_matches.sh CRISPR_1f.fna ERR430992.fna perfect_matches.txt"
  exit 1
fi

query_file="$1"
subject_file="$2"
output_file="$3"

makeblastdb -in "$subject_file" -dbtype nucl -out "${subject_file}_db"

blastn -query "$query_file" -db "${subject_file}_db" -outfmt 6 -perc_identity 100 > "$output_file"

num_matches=$(wc -l < "$output_file")

echo "Found $num_matches perfect matches in $output_file."
