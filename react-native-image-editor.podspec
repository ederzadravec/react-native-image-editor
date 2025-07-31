Pod::Spec.new do |s|
  s.name         = "react-native-image-editor"
  s.version      = "1.0.0"
  s.summary      = "Native bridge to embed a Flutter image editor in React Native"
  s.description  = "This React Native module embeds a Flutter image editor and communicates using FlutterEngine and MethodChannel."
  s.homepage     = "https://github.com/ederzadravec/react-native-image-editor"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Eder Zadravec" => "ederzadravec@gmail.com" }

  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/ederzadravec/react-native-image-editor.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{m,swift}"

  s.vendored_frameworks = [
    'ios/Flutter/Release/App.xcframework',
    'ios/Flutter/Release/FlutterPluginRegistrant.xcframework'
  ]
  s.exclude_files = ['android/**/*', '**/android/**/*']
  s.preserve_paths = ['android']

  s.requires_arc = true
  s.swift_version = "5.0"

  s.dependency "Flutter"
  s.dependency 'React-Core'
  s.dependency 'React'

end
