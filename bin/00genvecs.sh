#!/bin/bash

FILES=(akiyo_cif_short.y4m ducks_take_off_short.y4m grandma_short.y4m park_joy_short.y4m sign_irene_short.y4m sintel_trailer_2k_short.y4m soccer_short.y4m)
BASEURL=https://people.xiph.org/~tdaede/sets/video-1-short/
BASEDIR=$(readlink -f "$(dirname "$(readlink -f "$0")")"/../)

# make sure we're in a sane directory
mkdir -p "$BASEDIR"/tmp
cd "$BASEDIR"/tmp

# grab the files
for i in ${FILES[@]}; do
    wget "${BASEURL}"/"$i"
done

for j in 2 3; do
    TDIR=../"${j}""frames"
    mkdir -p "$TDIR"

    for i in ${FILES[@]}; do
        ffmpeg -i "$i" -frames $j tmp.y4m
        SUM="$(sha1sum tmp.y4m | cut -d \  -f 1)"
        mv tmp.y4m "$TDIR"/"$SUM".y4m
    done
done
