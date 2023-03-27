#!/usr/bin/env sh
set -e
DIR=~/Downloads
APP=yq
MIRROR=https://github.com/mikefarah/${APP}/releases/download

dl() {
    local ver=$1
    local os=$2
    local arch=$3
    local dotexe=${4:-}
    local platform="${os}_${arch}"
    local rfile="${app}_${platform}${dotexe}"
    local url=$MIRROR/v$ver/$rfile
    printf "    # %s\n" $url
    printf "    %s: md5:%s\n" $platform $(grep -e "^$rfile " $lchecksums | awk '{print $4}')
}

dl_ver() {
    local ver=$1
    local app=yq
    local url=$MIRROR/v$ver/checksums

    local lchecksums=$DIR/${app}-${ver}-checksums
    if [ ! -e $lchecksums ];
    then
        curl -sSLf -o $lchecksums $url
    fi

    printf "  # %s\n" $url
    printf "  '%s':\n" $ver

    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver freebsd 386
    dl $ver freebsd amd64
    dl $ver freebsd arm
    dl $ver linux 386
    dl $ver linux amd64
    dl $ver linux arm
    dl $ver linux arm64
    dl $ver linux mips
    dl $ver linux mips64
    dl $ver linux mips64le
    dl $ver linux mipsle
    dl $ver linux ppc64
    dl $ver linux ppc64le
    dl $ver linux s390x
    dl $ver netbsd 386
    dl $ver netbsd amd64
    dl $ver netbsd arm
    dl $ver openbsd 386
    dl $ver openbsd amd64
    dl $ver windows 386 .exe
    dl $ver windows amd64 .exe
}

dl_ver ${1:-4.33.1}
