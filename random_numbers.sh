#!/bin/bash

# Variable named max_number to define the maximum number of randomly ordered numbers
max_number=10     

# Checking if max_number is a positive integer, I make use of ! to deny regular expression
if [[ ! "$max_number" =~ ^[1-9][0-9]*$ ]]; then
    echo "Please enter a positive valid integer for max_number..."
else
    # Generating a random permutation of numbers from 1 to max_number using shuf
    seq 1 $max_number | shuf
fi
