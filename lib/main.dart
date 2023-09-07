import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/class/navigationKeys.dart';
import 'package:flame_setup_tuorial/play_game.dart';
import 'package:flame_setup_tuorial/weigth/heart_boss_progress_bar.dart';
import 'package:flame_setup_tuorial/weigth/heart_player_progress_bar.dart';
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
            ),
            //Decore Heart the boss
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.topRight,
                child: HeartBossProgressBar(value: 100.0),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 40, top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: HeartPlayerProgressBar(value: 100),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
