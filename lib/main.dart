import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/derection.dart';
import 'package:flame_setup_tuorial/derection_interface.dart';
import 'package:flutter/material.dart';

void main() {
  print('load the game widgets');
  final game = MyGame();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: NavigationKeys(
                  onDirectionChanged: game.onArrowKeyChanged(Direction.down),
                ),
              )),
        ],
      ),
    ),
  ));
}

class MyGame extends FlameGame {
  Direction direction = Direction.none;

  onArrowKeyChanged(Direction direction) {
    direction = direction;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('load game assets');
  }
}
