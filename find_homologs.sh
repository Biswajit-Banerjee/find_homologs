#!/bin/bash

# Check for correct usage
if [ $# -ne 3 ]; then
	    echo "Usage: ./find_perfect_matches.sh <query file> <subject file> <output file>"
	        exit 1
fi

# Input files
query_file="$1"
subject_file="$2"

# Output file
output_file="$3"

# Run BLAST and store the output in a temporary file
blast_output=$(mktemp blast_output.XXXXXXXXXX)
blastn -query "$query_file" -subject "$subject_file" -out "$blast_output" -outfmt "6 qseqid sseqid qlen slen length pident"

# Extract perfect matches (100% identity and equal length)
awk '$5 == $3 && $6 == 100 {print $1}' "$blast_output" > "$output_file"

# Count and print the number of perfect matches
perfect_match_count=$(wc -l < "$output_file")
echo "Number of perfect matches: $perfect_match_count"

# Clean up temporary files
echo "blast file: $blast_output"

