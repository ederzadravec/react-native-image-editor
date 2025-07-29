#!/bin/bash
pwd 
rm  -Rf ios/Flutter
mkdir -p ios/Flutter
cp -Rf flutter_module/* ios/Flutter
cd ios/Flutter || exit 1
flutter clean
flutter pub get
flutter build ios-framework --output=./Flutter
cd ../..
