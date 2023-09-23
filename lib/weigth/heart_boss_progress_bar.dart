import 'package:flutter/material.dart';

class HeartBossProgressBar extends StatelessWidget {
  final int value;
  final double width;
  final double height;

  HeartBossProgressBar(
      {required this.value, this.width = 300.0, this.height = 35.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            height / 2), // Độ cong để tạo hình dạng trái tim
        border: Border.all(color: Colors.red, width: 2.0),
      ),
      child: Stack(
        children: [
          Container(
            width: 300,
            child: Center(
                child: Text(
              '$value',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              color: Color.fromARGB(255, 255, 11, 11),
            ),
          ),
        ],
      ),
    );
  }
}
