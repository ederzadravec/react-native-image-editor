import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  final Uint8List imageData;

  const ImageBackground({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageData,
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
