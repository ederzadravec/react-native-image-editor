import 'package:flutter/material.dart';

class PenButtons extends StatelessWidget {
  final VoidCallback increasePen;
  final VoidCallback decreasePen;

  const PenButtons({
    super.key,
    required this.increasePen,
    required this.decreasePen,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SafeArea(
        right: true,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove, color: Colors.white),
                onPressed: decreasePen,
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: increasePen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
