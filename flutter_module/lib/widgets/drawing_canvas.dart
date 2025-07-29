import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

import 'drawing_painter.dart';
import 'drawn_line.dart';
import '../widgets/image_background.dart';

class DrawingCanvas extends StatefulWidget {
  final Uint8List backgroundImage;
  final bool isPenActive;
  final double penStrokeWidth;

  const DrawingCanvas({
    super.key,
    required this.backgroundImage,
    required this.isPenActive,
    required this.penStrokeWidth,
  });

  @override
  State<DrawingCanvas> createState() => DrawingCanvasState();
}

class DrawingCanvasState extends State<DrawingCanvas> {
  final TransformationController _transformationController =
      TransformationController();

  final GlobalKey _repaintKey = GlobalKey();

  List<DrawnLine> _lines = [];
  DrawnLine? _currentLine;
  Matrix4? _inverseMatrix;

  @override
  void didUpdateWidget(covariant DrawingCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Opcional: pode resetar a matriz inversa se quiser
  }

  Offset _transformPosition(Offset globalPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(globalPosition);
    final inverseMatrix = Matrix4.inverted(_transformationController.value);
    final transformedVector = inverseMatrix.transform3(
      vmath.Vector3(localPosition.dx, localPosition.dy, 0),
    );
    return Offset(transformedVector.x, transformedVector.y);
  }

  void _onPanStart(DragStartDetails details) {
    final point = _transformPosition(details.globalPosition);

    setState(() {
      _currentLine = DrawnLine(
        points: [point],
        strokeWidth: widget.penStrokeWidth,
        color: Colors.black,
      );
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final point = _transformPosition(details.globalPosition);
    setState(() {
      _currentLine?.points.add(point);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentLine != null) {
      _lines.add(_currentLine!);
      setState(() {
        _currentLine = null;
      });
    }
  }

  Future<Uint8List?> exportDrawing() async {
    try {
      RenderRepaintBoundary boundary =
          _repaintKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Erro ao exportar desenho: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _repaintKey,
      child: InteractiveViewer(
        transformationController: _transformationController,
        maxScale: 4.0,
        minScale: 1.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageBackground(imageData: widget.backgroundImage),
            AbsorbPointer(
              absorbing: !widget.isPenActive,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  painter: DrawingPainter(
                    lines: [..._lines, if (_currentLine != null) _currentLine!],
                  ),
                  size: Size.infinite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
