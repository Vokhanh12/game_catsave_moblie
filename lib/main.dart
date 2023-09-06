import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/class/navigationKeys.dart';
import 'package:flame_setup_tuorial/play_game.dart';
import 'package:flutter/material.dart';

void main() async {
  final game = PlayGame();
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã sẵn sàng
  await Flame.device.setLandscape();
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
