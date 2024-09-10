#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <assembly file> <BED file>"
  exit 1
fi

ASSEMBLY_FILE="$1"
BED_FILE="$2"
OUTPUT_FILE="spacers.fna"

if [[ ! -f "$ASSEMBLY_FILE" ]]; then
  echo "Error: Assembly file '$ASSEMBLY_FILE' not found."
  exit 1
fi

if [[ ! -f "$BED_FILE" ]]; then
  echo "Error: BED file '$BED_FILE' not found."
  exit 1
fi

seqtk subseq "$ASSEMBLY_FILE" "$BED_FILE" > "$OUTPUT_FILE"

echo "Spacer sequences have been saved to '$OUTPUT_FILE'."