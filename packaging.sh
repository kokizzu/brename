#!/usr/bin/env sh

# https://github.com/mitchellh/gox
CGO_ENABLED=0 gox -os="windows darwin linux" -arch="386 amd64 arm64" -tags netgo -ldflags '-w -s'

dir=binaries
mkdir -p $dir;
rm -rf $dir/$f;

brename -p ^v2 -r brename -q

for f in brename_*; do
    mkdir -p $dir/$f;
    mv $f $dir/$f;
    cd $dir/$f;
    mv $f $(echo $f | perl -pe 's/_[^\.]+//g');
    tar -zcf $f.tar.gz brename*;
    mv *.tar.gz ../;
    cd ..;
    rm -rf $f;
    cd ..;
done;
