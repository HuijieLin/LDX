#!/bin/sh
cd `dirname "$0"`

./ldx  -ObjC -o ./PortalObjC -demangle -dynamic -arch armv7 -dead_strip -exported_symbols_list exported_symbols ...
./ldx        -o ./PortalLite -demangle -dynamic -arch armv7 -dead_strip -exported_symbols_list exported_symbols ...

otool -o -V ./ObjC | grep "_OBJC_CLASS" | cut -d " " -f3 | sort | uniq > ./ObjC.txt
otool -o -V ./Lite | grep "_OBJC_CLASS" | cut -d " " -f3 | sort | uniq > ./Lite.txt
comm -23 ./ObjC.txt ./Lite.txt > ./NoRef.txt
