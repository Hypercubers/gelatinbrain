#!/bin/bash

cd "$(dirname $0)" # Set working directory to script directory

if [ ! -x jdk-19.0.2 ]; then
    echo "Java 19.0.2 not found! Downloading it now."
    case "$(uname -s)" in
        Darwin*)    os=macos;;
        Linux*)     os=linux;;
    esac
    echo "Detected you're running $os"
    echo "Downloading ..."
    curl "https://download.oracle.com/java/19/archive/jdk-19.0.2_${os}-x64_bin.tar.gz" --output jdk-19.0.2.tar.gz
    echo "Extracting ..."
    tar -xf jdk-19.0.2.tar.gz
    if [ "$os" = "macos" ]; then
        mv jdk-19.0.2.jdk/Contents/Home jdk-19.0.2
        rm -r jdk-19.0.2.jdk
    fi
    rm jdk-19.0.2.tar.gz
fi

PATH="$(pwd)/jdk-19.0.2/bin:$PATH"

run_permuzzle() {
    echo "Deleting old session file ..."
    rm -r permuzzle/sessions

    echo "Running permuzzle ..."
    java --add-exports java.base/java.lang=ALL-UNNAMED \
        --add-exports java.desktop/sun.awt=ALL-UNNAMED \
        --add-exports java.desktop/sun.java2d=ALL-UNNAMED \
        -cp permuzzle/permuzzle.jar:jogl/gluegen-rt.jar:jogl/jogl-all.jar \
        jzzz.CStart
}

run_permuzzle
while [ -f permuzzle/sessions/.default.zzz ]; do
    echo "Detected that program was closed with puzzle open"
    echo "Restarting program ..."
    run_permuzzle
done
