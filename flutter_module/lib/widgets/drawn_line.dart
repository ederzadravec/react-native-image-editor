import 'package:flutter/material.dart';

class DrawnLine {
  final List<Offset> points;
  final double strokeWidth;
  final Color color;

  DrawnLine({
    required this.points,
    required this.strokeWidth,
    required this.color,
  });
}
