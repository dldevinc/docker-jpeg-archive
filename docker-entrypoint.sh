#!/usr/bin/env sh


E_INVALID_USAGE=1
USAGE=$(cat <<-END
Usage: $0 file [options]
Examples:
  $0 ./input.jpg --quiet --strip --quality medium --method smallfry ./output.jpg
  $0 ./images --quiet --strip --quality medium --method smallfry
END
)

if [ $# -eq 0 ]; then
    >&2 echo "$USAGE"
    exit $E_INVALID_USAGE
fi


if [ -d "$1" ]; then
    folder=$1
    shift
    options=$@

    # Find all JPEG files
    for file in $folder/*; do
        if [ -f "$file" ] && echo "$file" | grep -qiE ".jpe?g"; then
            echo "$file" >> /tmp/images.list
        fi
    done

    # Process files in parallel
    pexec -f /tmp/images.list -e IMG -c -o - -- "$0 \$IMG $options \$IMG"
else
    # Process single file
    file=$1
    shift

    # hack to get last argument
    for outfile; do true; done
    
    options=${@:0:-${#outfile}}
    exec jpeg-recompress $options $file $outfile
fi
