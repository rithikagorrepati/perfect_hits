#!/bin/bash

# Usage: ./find_homologs.sh <query file> <subject file> <output file>

if [ "$#" -ne 3 ]; then
    echo "Usage: ./find_homologs.sh <query file> <subject file> <output file>"
    exit 1
fi

QUERY=$1
SUBJECT=$2
OUTPUT=$3

blastx -query "$QUERY" -db "$SUBJECT" -outfmt 6 -perc_identity 30 -qcov_hsp 0.9 > "$OUTPUT"

NUM_MATCHES=$(wc -l < "$OUTPUT")
echo "Number of matches: $NUM_MATCHES"

