Pod::Spec.new do |s|
  s.name         = "react-native-image-editor"
  s.version      = "1.0.0"
  s.summary      = "React Native bridge for Flutter-based image editor"
  s.description  = "A native module that integrates a Flutter-based image editor into React Native."
  s.homepage     = "https://github.com/ederzadravec/react-native-image-editor"
  s.license      = "MIT"
  s.author       = { "Eder Zadravec" => "ederzadravec@gmail.com" }
  s.source       = { :git => "https://github.com/ederzadravec/react-native-image-editor.git", :tag => "#{s.version}" }

  s.platform     = :ios, "11.0"
  s.requires_arc = true
  s.swift_version = "5.0" # ou outra versão que você usa

  # Apenas os arquivos nativos (iOS bridge)
  s.source_files = "ios/**/*.{h,m,swift}"

  # Evita conflitos com arquivos internos do Flutter
  s.exclude_files = [
    "flutter_module/.ios/Flutter/Flutter.podspec",
    "flutter_module/.ios/Flutter/GeneratedPluginRegistrant/**/*",
    "flutter_module/build/**",
    "flutter_module/ios/**",
    "flutter_module/.dart_tool/**",
    "flutter_module/.packages",
    "flutter_module/.flutter-plugins-dependencies"
  ]

  # Dependência do Flutter será injetada via podhelper.rb no app
end
