#!/bin/bash

echo "📦 Iniciando build do módulo Flutter para iOS e Android..."

FLUTTER_MODULE=flutter_module

# Limpa e prepara o módulo Flutter
cd $FLUTTER_MODULE || exit 1
flutter clean
flutter pub get

# Build iOS (frameworks)
flutter build ios-framework --output=build/ios-framework

# Build Android (AAR)
flutter build aar

cd ..

# 🔹 COPIA BUILD iOS
rm -rf ios/Flutter
mkdir -p ios/Flutter
cp -r $FLUTTER_MODULE/.ios/Flutter ios/Flutter/
cp -r $FLUTTER_MODULE/build/ios-framework ios/Flutter/frameworks
cp $FLUTTER_MODULE/pubspec.yaml ios/Flutter/

# 🔹 COPIA BUILD ANDROID
rm -rf android/flutter-build
mkdir -p android/flutter-build
cp -r $FLUTTER_MODULE/build/host/outputs/repo android/flutter-build/maven
