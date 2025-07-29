import { NativeModules, Platform } from "react-native";

const { ReactNativeImageEditor } = NativeModules;

export function setImage(base64Image) {
  if (!ReactNativeImageEditor) {
    throw new Error("ReactNativeImageEditor native module not linked");
  }
  return ReactNativeImageEditor.sendImageToFlutter(base64Image);
}

export function showEditor() {
  if (!ReactNativeImageEditor) {
    throw new Error("ReactNativeImageEditor native module not linked");
  }
  return ReactNativeImageEditor.showFlutterActivity
    ? ReactNativeImageEditor.showFlutterActivity()
    : ReactNativeImageEditor.showFlutterView();
}
