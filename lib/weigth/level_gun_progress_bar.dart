import 'package:flutter/material.dart';

class LevelGunProgressBar extends StatelessWidget {
  final double? levelgun;

  LevelGunProgressBar({required this.levelgun});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Level gun: ${levelgun}',
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }
}
