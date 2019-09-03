#!/usr/bin/env zsh

set -e
set -u

# We need input and output dir
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 indir outdir" >&2
  exit 1
fi

indir=${1:?"input dir must be specified"}
outdir=${2:?"output dir must be specified"}

info() {
    # shellcheck disable=SC2059
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

mkdir -p ${outdir}

for file in ${indir}/*.png(.)
{
    info "Processing ${file}"
    filename=$(basename "${file%.*}")
    convert $file -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace RGB ${outdir}/${filename}.jpg
}
