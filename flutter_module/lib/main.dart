import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MaterialApp(home: ImageEditorScreen()));
}

class ImageEditorScreen extends StatefulWidget {
  const ImageEditorScreen({Key? key}) : super(key: key);
  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  Uint8List? _imageBytes;
  final _signatureController = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.red,
  );

  static const MethodChannel _channel = MethodChannel(
    'flutter_image_editor_channel',
  );

  Future<void> _pickAndCropImage() async {
    final picker = ImagePicker();
    final pf = await picker.pickImage(source: ImageSource.gallery);
    if (pf == null) return;
    final cropped = await ImageCropper().cropImage(
      sourcePath: pf.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
      ],
    );
    if (cropped == null) return;
    final bytes = await cropped.readAsBytes();
    setState(() => _imageBytes = bytes);
  }

  Future<void> _saveImageAndReturn() async {
    if (_imageBytes == null) return;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    final img = await decodeImageFromList(_imageBytes!);
    canvas.drawImage(img, const Offset(0, 0), paint);

    final sigImg = await _signatureController.toImage();
    final bdata = await sigImg.toByteData(format: ui.ImageByteFormat.png);
    if (bdata != null) {
      final overlay = await decodeImageFromList(bdata.buffer.asUint8List());
      canvas.drawImage(overlay, const Offset(0, 0), paint);
    }

    final finalImg = await recorder.endRecording().toImage(
      img.width,
      img.height,
    );
    final fdata = await finalImg.toByteData(format: ui.ImageByteFormat.png);

    if (fdata != null) {
      final base64Str = base64Encode(fdata.buffer.asUint8List());
      await _channel.invokeMethod('imageEdited', {'base64': base64Str});
    }
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor de Imagem'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveImageAndReturn,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (_imageBytes != null)
                  Positioned.fill(
                    child: Image.memory(_imageBytes!, fit: BoxFit.contain),
                  ),
                Positioned.fill(
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.photo_library),
                onPressed: _pickAndCropImage,
              ),
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: () => _signatureController.undo(),
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _signatureController.clear(),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
