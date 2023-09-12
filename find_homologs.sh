#!/bin/bash

# Input files
query_file="$1"
subject_file="$2"

# Output file
output_file="$3"

# Run BLAST and store the output in a temporary file
blast_output=$(mktemp blast_output.XXXXXXXXXX)
blastn -query "$query_file" -subject "$subject_file" -out "$blast_output" -outfmt "6 qseqid sseqid qlen slen length pident"
i
# Extract perfect matches (100% identity and equal length)
#awk '$5 == $3 && $6 == 100 {print $1}' "$blast_output" > "$output_file"

# Filter hits based on >30% sequence identity and >90% match length
awk '$6 > 30 && ($5 / $3) > 0.9 {print $1}' "$blast_output" > "$output_file"


# Count and print the number of perfect matches
perfect_match_count=$(wc -l < "$output_file")
echo "Number of perfect matches: $perfect_match_count"

# Clean up temporary files
#echo "blast file: $blast_output"

