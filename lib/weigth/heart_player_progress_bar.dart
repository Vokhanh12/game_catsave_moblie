import 'package:flutter/material.dart';

class HeartPlayerProgressBar extends StatelessWidget {
  final int value;
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
            Container(
                child: Row(
                  children: List.generate(
                    value, // Tạo số lượng biểu tượng dựa trên giá trị
                    (index) => Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: height * 1,
                    ),
                  ),
              ),
            ),
            Container(
                child: Row(
                  children: List.generate(
                    5 - value, // Tạo số lượng biểu tượng dựa trên giá trị
                    (index) => Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 124, 120, 120),
                      size: height * 1,
                    ),
                  ),
                ),
            ),
        ],
      ),
    );
  }
}
