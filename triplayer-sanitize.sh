#!/bin/bash
set -euo pipefail

# TriPlayer Filename Sanitizer
# Converts accents to ASCII and replaces weird chars with underscores.
# Run from the root of your music collection.

DRY_RUN="${DRY_RUN:-0}"

find . -depth -name "*[^a-zA-Z0-9._ -]*" | while IFS= read -r path; do
    dir=$(dirname "$path")
    base=$(basename "$path")
    newbase=$(echo "$base" | iconv -f UTF-8 -t ASCII//TRANSLIT | sed 's/[^a-zA-Z0-9._ -]/_/g')

    if [ "$base" != "$newbase" ]; then
        target="$dir/$newbase"
        
        if [ -e "$target" ]; then
            name="${newbase%.*}"
            ext="${newbase##*.}"
            if [ "$ext" = "$newbase" ]; then
                counter=1
                while [ -e "$dir/${name}_$counter" ]; do
                    counter=$((counter + 1))
                done
                target="$dir/${name}_$counter"
            else
                counter=1
                while [ -e "$dir/${name}_$counter.$ext" ]; do
                    counter=$((counter + 1))
                done
                target="$dir/${name}_$counter.$ext"
            fi
        fi

        if [ "$DRY_RUN" -eq 1 ]; then
            echo "[DRY RUN] '$path' -> '$target'"
        else
            mv -v "$path" "$target"
        fi
    fi
done