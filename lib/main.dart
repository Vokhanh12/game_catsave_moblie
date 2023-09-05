import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/play_game.dart';
import 'package:flame_setup_tuorial/weigth/navigationKeys.dart';
import 'package:flutter/material.dart';

void main() {
  final game = PlayGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: NavigationKeys(
                  onDirectionChanged: game.onArrowKeyChanged,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
