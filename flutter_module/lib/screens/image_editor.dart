import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/drawing_canvas.dart';

import '../widgets/top_toolbar.dart';
import '../widgets/bottom_toolbar.dart';
import '../widgets/pen_buttons.dart';

class ImageEditor extends StatefulWidget {
  final Uint8List imageData;

  const ImageEditor({super.key, required this.imageData});

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  static const MethodChannel channel = MethodChannel('image_editor_channel');

  late Uint8List _imageBytes;
  bool _isPenActive = false;
  double _penStrokeWidth = 8;

  final GlobalKey<DrawingCanvasState> _drawingCanvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _imageBytes = widget.imageData;
  }

  Future<void> _cropImage() async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp_image_for_crop.png');
    await tempFile.writeAsBytes(_imageBytes);

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: tempFile.path,
    );

    if (croppedFile != null) {
      final croppedBytes = await croppedFile.readAsBytes();
      setState(() => _imageBytes = croppedBytes);
    }

    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  }

  void _togglePen() {
    setState(() => _isPenActive = !_isPenActive);
  }

  void _increasePenWidth() {
    setState(() => _penStrokeWidth = (_penStrokeWidth + 2).clamp(2, 20));
  }

  void _decreasePenWidth() {
    setState(() => _penStrokeWidth = (_penStrokeWidth - 2).clamp(2, 20));
  }

  Future<void> _finalizeEdit() async {
    final state = _drawingCanvasKey.currentState;
    if (state == null) return;

    final pngBytes = await state.exportDrawing();
    if (pngBytes == null) return;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/edited_image.png');
    await file.writeAsBytes(pngBytes);

    final base64Image = base64Encode(pngBytes);
    await channel.invokeMethod('onImageEdited', base64Image);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawingCanvas(
            key: _drawingCanvasKey,
            backgroundImage: _imageBytes,
            isPenActive: _isPenActive,
            penStrokeWidth: _penStrokeWidth,
          ),
          TopToolbar(
            isPenActive: _isPenActive,
            onCancel: () => Navigator.pop(context),
            onCrop: _cropImage,
            onPen: _togglePen,
          ),
          BottomToolbar(onDone: _finalizeEdit),
          PenButtons(
            increasePen: _increasePenWidth,
            decreasePen: _decreasePenWidth,
          ),
        ],
      ),
    );
  }
}
