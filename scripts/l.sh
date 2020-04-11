#!/bin/sh

for file in *
do
    # echo $file
    NO_WHITESPACE="$(echo "$file" | tr -d '[:space:]')"
    mv "$file" "$NO_WHITESPACE"
done

