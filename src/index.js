import { NativeModules } from 'react-native';

const { ReactNativeImageEditor } = NativeModules;

console.log({ ReactNativeImageEditor})
export default {
  showFlutterView: () => ReactNativeImageEditor.showFlutterView(),
};
