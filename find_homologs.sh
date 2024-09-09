#!/bin/bash

# Usage: ./find_homologs.sh <query file> <subject file> <output file>

if [ "$#" -ne 3 ]; then
    echo "Usage: ./find_homologs.sh <query file> <subject file> <output file>"
    exit 1
fi

QUERY=$1
SUBJECT=$2
OUTPUT=$3

# Perform BLAST search (using blastx since it's protein query vs. nucleotide subject)
blastx -query "$QUERY" -db "$SUBJECT" -outfmt 6 -qcov_hsp_perc 90 > blast_results.txt

# Filter hits with >30% identity and >90% query coverage
awk '$3 > 30 && $4 > 90' blast_results.txt > "$OUTPUT"

# Count the number of matches
NUM_MATCHES=$(wc -l < "$OUTPUT")
echo "Number of matches: $NUM_MATCHES"


