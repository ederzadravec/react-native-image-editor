#!/bin/bash

set -e

echo "🧹 Limpando build antigo..."
cd flutter_module
flutter clean
flutter pub get

echo "⚙️  Gerando iOS frameworks..."
flutter build ios-framework --output=./Flutter --no-profile --no-debug --cocoapods

cd ..
echo "🚚 Movendo frameworks para pasta ios/Flutter..."
rm -rf ios/Flutter
mkdir -p ios/Flutter
mv flutter_module/Flutter/* ios/Flutter/

echo "✅ Build finalizado com sucesso!"
