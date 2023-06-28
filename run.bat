@echo off

set BASEDIR=%~dp0
cd %BASEDIR%

if not exist jdk-19.0.2 (
    echo "Java 19.0.2 not found! Downloading it now."
    echo "Downloading ..."
    curl "https://download.oracle.com/java/19/archive/jdk-19.0.2_windows-x64_bin.zip" --output jdk-19.0.2.zip
    echo "Extracting ..."
    tar -xf jdk-19.0.2.zip
    del jdk-19.0.2.zip
)

set PATH=%BASEDIR%\jdk-19.0.2\bin;%PATH%

echo "Running permuzzle ..."
java --add-exports java.base/java.lang=ALL-UNNAMED ^
     --add-exports java.desktop/sun.awt=ALL-UNNAMED ^
     --add-exports java.desktop/sun.java2d=ALL-UNNAMED ^
     -cp permuzzle\permuzzle.jar;jogl\gluegen-rt.jar;jogl\jogl-all.jar ^
    jzzz.CStart
