import 'package:flutter/material.dart';

class CoordinateDisplay extends StatelessWidget {
  final double x;
  final double y;

  CoordinateDisplay({required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y - 20, // Điều chỉnh vị trí hiển thị tọa độ
      left: x,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '($x, $y)',
          style: TextStyle(color: const Color.fromARGB(255, 255, 0, 0)),
        ),
      ),
    );
  }
}
