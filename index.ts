import { NativeModules } from "react-native";

const { FlutterImageEditor } = NativeModules;

export async function openImageEditor(): Promise<string> {
  if (!FlutterImageEditor) throw new Error("FlutterImageEditor native module not linked");
  return await FlutterImageEditor.openEditor();
}
