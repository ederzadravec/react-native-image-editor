const fs = require("fs");
const path = require("path");

const foldersToRemove = [
  "flutter_module/build",
  "flutter_module/.dart_tool",
  "flutter_module/.flutter-plugins",
  "flutter_module/.flutter-plugins-dependencies",
  "flutter_module/.packages",
  "flutter_module/.metadata",
  "flutter_module/.ios/Flutter/ephemeral",
  "ios/Pods",
];

foldersToRemove.forEach((folder) => {
  const fullPath = path.resolve(__dirname, "..", folder);
  if (fs.existsSync(fullPath)) {
    fs.rmSync(fullPath, { recursive: true, force: true });
    console.log(`✔️  Removed: ${folder}`);
  }
});
