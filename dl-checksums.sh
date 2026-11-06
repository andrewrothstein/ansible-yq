#!/usr/bin/env bash
set -e
DIR=~/Downloads
APP=yq
MIRROR=https://github.com/mikefarah/${APP}/releases/download

dl() {
    local lchecksums=$1
    local col=$2
    local ver=$3
    local os=$4
    local arch=$5
    local dotexe=${6:-}
    local platform="${os}_${arch}"
    local rfile="${APP}_${platform}${dotexe}"
    local url=$MIRROR/v$ver/$rfile
    local sum
    sum=$(awk -v f="$rfile" -v c="$col" '$1 == f {print $c}' "$lchecksums")
    if ! printf '%s' "$sum" | grep -Eq '^[0-9a-f]{64}$'; then
        echo "no valid sha256 for $rfile in $lchecksums" >&2
        exit 1
    fi
    printf "    # %s\n" "$url"
    printf "    %s: sha256:%s\n" "$platform" "$sum"
}

dl_ver() {
    local ver=$1
    local url=$MIRROR/v$ver/checksums
    local order_url=$MIRROR/v$ver/checksums_hashes_order

    local lchecksums=$DIR/${APP}-${ver}-checksums
    local lorder=$DIR/${APP}-${ver}-checksums_hashes_order
    if [ ! -e "$lchecksums" ];
    then
        curl -fsSL --proto '=https' --tlsv1.2 -o "$lchecksums" "$url"
    fi
    if [ ! -e "$lorder" ];
    then
        curl -fsSL --proto '=https' --tlsv1.2 -o "$lorder" "$order_url"
    fi
    # field 1 is the file name, hash N of the order file is field N+1
    local col
    col=$(( $(grep -n -x 'SHA-256' "$lorder" | cut -d: -f1) + 1 ))

    printf "  # %s\n" "$url"
    printf "  '%s':\n" "$ver"

    dl "$lchecksums" "$col" "$ver" darwin amd64
    dl "$lchecksums" "$col" "$ver" darwin arm64
    dl "$lchecksums" "$col" "$ver" freebsd 386
    dl "$lchecksums" "$col" "$ver" freebsd amd64
    dl "$lchecksums" "$col" "$ver" freebsd arm
    dl "$lchecksums" "$col" "$ver" linux 386
    dl "$lchecksums" "$col" "$ver" linux amd64
    dl "$lchecksums" "$col" "$ver" linux arm
    dl "$lchecksums" "$col" "$ver" linux arm64
    dl "$lchecksums" "$col" "$ver" linux mips
    dl "$lchecksums" "$col" "$ver" linux mips64
    dl "$lchecksums" "$col" "$ver" linux mips64le
    dl "$lchecksums" "$col" "$ver" linux mipsle
    dl "$lchecksums" "$col" "$ver" linux ppc64
    dl "$lchecksums" "$col" "$ver" linux ppc64le
    dl "$lchecksums" "$col" "$ver" linux s390x
    dl "$lchecksums" "$col" "$ver" netbsd 386
    dl "$lchecksums" "$col" "$ver" netbsd amd64
    dl "$lchecksums" "$col" "$ver" netbsd arm
    dl "$lchecksums" "$col" "$ver" openbsd 386
    dl "$lchecksums" "$col" "$ver" openbsd amd64
    dl "$lchecksums" "$col" "$ver" windows 386 .exe
    dl "$lchecksums" "$col" "$ver" windows amd64 .exe
}

for v in "${@:-4.54.2}"; do
    dl_ver "$v"
done
