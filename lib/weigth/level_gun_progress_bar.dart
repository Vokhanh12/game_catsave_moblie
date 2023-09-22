import 'package:flutter/material.dart';

class LevelGunProgressBar extends StatelessWidget {
  final int? levelgun;

  LevelGunProgressBar({required this.levelgun});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: List.generate(
        levelgun!,
        (index) => Icon(
          Icons.rectangle,
          color: Colors.red,
          size: levelgun! * 1,
        ),
      ),
    )

        /*
      child: Text(
        'Level gun: ${levelgun}',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      */
        );
  }
}
