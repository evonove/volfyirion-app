#!/usr/bin/env zsh

set -e
set -u

# We need at least the file name
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 FILE" >&2
  exit 1
fi

info() {
    # shellcheck disable=SC2059
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

function process_image() {
    original=${1:?"original image must be specified"}
    destination=${2:?"destination image must be specified"}
    size=${3:?"size must be specified"}
    quality=${4:?"quality must be specified"}
    colors=${5:?"colors must be specified"}
    dimension=${6:?"dimension must be specified"}

    if [[ $dimension = "width" ]]; then
        convert -resize ${size}x ${original} ${destination}
    else
        convert -resize x${size} ${original} ${destination}
    fi

    pngquant ${colors} --strip --quality ${quality} --force --ext .png ${destination}
    optipng -strip all ${destination} &> /dev/null
}

curdir=$(pwd -P)
outdir=${curdir}/process

# Create the output directory
mkdir -p ${outdir}

for filepath cmd colors quality dimension x1 x2 x3 x4 in "${(@s:,:)"${(f)"$(<$1)"}"}"
{
    filename=$(basename "${filepath%.*}")
    dst=${outdir}/$(dirname ${filepath})
    mkdir -p ${dst}

    if [[ $cmd = "process" ]]; then
        info "Processing ${filepath}"
        process_image ${curdir}/orig/${filepath} ${dst}/${filename}.png ${x1} ${quality} ${colors} ${dimension}
        process_image ${curdir}/orig/${filepath} ${dst}/${filename}@2x.png ${x2} ${quality} ${colors} ${dimension}
        process_image ${curdir}/orig/${filepath} ${dst}/${filename}@3x.png ${x3} ${quality} ${colors} ${dimension}
        process_image ${curdir}/orig/${filepath} ${dst}/${filename}@4x.png ${x4} ${quality} ${colors} ${dimension}
    else
        info "Copying ${filepath}"
        cp ${curdir}/orig/${filepath} ${outdir}/${filepath}
    fi
}

