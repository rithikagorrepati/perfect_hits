#!/bin/bash

# Check if correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <assembly.fasta> <repeat.fasta>"
    exit 1
fi

assembly=$1
repeat=$2

# Find perfect matches
blastn -query $repeat -subject $assembly -task blastn-short -outfmt 6 | \
    awk '$3==100 && $4==length($1)' > perfect_matches.txt

# Extract spacer coordinates
awk 'BEGIN {OFS="\t"} 
     NR>1 {
        start = $9 + $4
        end = $7 - 1
        if (start < end) 
            print $2, start, end
     }' perfect_matches.txt > spacers.bed

# Extract spacer sequences
seqtk subseq $assembly spacers.bed > spacers.fasta

echo "Spacer sequences extracted to spacers.fasta"