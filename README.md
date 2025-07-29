
# react_native_image_editor

## Descrição
Lib React Native que integra um módulo Flutter para edição de imagem com desenho, zoom, corte e outras funcionalidades.

---

## Instalação

No seu projeto React Native, rode:

```bash
yarn add react_native_image_editor
```

ou

```bash
npm install react_native_image_editor
```

---

## iOS

1. Após instalar a lib, execute:

```bash
cd ios
pod install
```

2. Caso seu projeto não possua o arquivo `Podfile`, crie um na pasta `ios/` com o seguinte conteúdo básico:

```ruby
platform :ios, '11.0'

target 'SeuProjeto' do
  use_frameworks!
  use_modular_headers!

  pod 'Flutter', :path => '../node_modules/react_native_image_editor/flutter_module/.ios/Flutter'

  # Outras dependências...

  post_install do |installer|
    flutter_post_install(installer)
  end
end
```

3. Certifique-se que seu projeto abra no Xcode usando o arquivo `.xcworkspace`, não `.xcodeproj`.

4. Compile o projeto no Xcode ou usando `react-native run-ios`.

---

## Android

1. No `android/settings.gradle` do seu projeto React Native, adicione:

```gradle
include ':react_native_image_editor'
project(':react_native_image_editor').projectDir = new File(rootProject.projectDir, '../node_modules/react_native_image_editor/android')
```

2. No `android/app/build.gradle`, adicione a dependência:

```gradle
implementation project(':react_native_image_editor')
```

3. No `android/app/src/main/java/[...]/MainApplication.java`, registre o pacote:

```java
import com.react_native_image_editor.ReactNativeImageEditorPackage;

@Override
protected List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
        new MainReactPackage(),
        new ReactNativeImageEditorPackage()
    );
}
```

4. Compile e rode normalmente.

---

## Uso

Exemplo simples de uso:

```jsx
import React from 'react';
import { View } from 'react-native';
import ReactNativeImageEditor from 'react_native_image_editor';

export default function App() {
  return (
    <View style={{ flex: 1 }}>
      <ReactNativeImageEditor />
    </View>
  );
}
```

---

## Notas

- O módulo Flutter fica em `node_modules/react_native_image_editor/flutter_module`.
- A lib é entregue como um módulo React Native + Flutter embutido.
- Verifique as versões do Flutter, React Native e suas dependências.

---

## Suporte

Abra uma issue no repositório ou entre em contato.

