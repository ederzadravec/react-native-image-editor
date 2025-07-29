import 'package:flutter/material.dart';

class TopToolbar extends StatelessWidget {
  final bool isPenActive;
  final VoidCallback onCancel;
  final VoidCallback onCrop;
  final VoidCallback onPen;

  const TopToolbar({
    super.key,
    required this.isPenActive,
    required this.onCancel,
    required this.onCrop,
    required this.onPen,
  });

  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: onCancel,
              ),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.crop, color: Colors.white),
                onPressed: onCrop,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: isPenActive ? Colors.amber : Colors.white,
                ),
                onPressed: onPen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
