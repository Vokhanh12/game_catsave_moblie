import 'package:flutter/material.dart';

class HeartPlayerProgressBar extends StatelessWidget {
  final double value;
  final double width;
  final double height;

  HeartPlayerProgressBar(
      {required this.value, this.width = 200.0, this.height = 40.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            height / 2), // Độ cong để tạo hình dạng trái tim
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: width,
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: height *
                          1, // Điều chỉnh kích thước biểu tượng trái tim
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: height *
                          1, // Điều chỉnh kích thước biểu tượng trái tim
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: height *
                          1, // Điều chỉnh kích thước biểu tượng trái tim
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
