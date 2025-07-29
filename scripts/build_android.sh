#!/bin/bash
cd flutter_module

flutter clean
flutter pub get
flutter build aar

cd ../

rm  -Rf android/flutter_module
mkdir -p android/flutter_module

cp -Rf flutter_module/* android/flutter_module
cd android/flutter_module || exit 1
cd ../..
