#!/bin/bash

set -e  # para parar no erro

# Caminho para seu módulo Flutter
FLUTTER_MODULE_PATH="flutter_module"

# Limpa build e instala dependências Flutter
cd "$FLUTTER_MODULE_PATH"
flutter clean
flutter pub get

# Build dos frameworks iOS para múltiplas arquiteturas
flutter build ios-framework --output=./Flutter --no-profile --no-debug

cd ..
# Roda script Node para cleanup (se existir)
node scripts/prepublish-cleanup.js
