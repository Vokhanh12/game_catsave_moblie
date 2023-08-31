import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  SpriteComponent dog = SpriteComponent();
  SpriteComponent cat = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteComponent conversation_background = SpriteComponent();
  bool _isShowConiversation = false;
  final double characterSize = 220.0;
  final double startScreen = 150;
  final double conversationsSize = 100;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final screenWidth = size[0];
    final screenHeigth = size[1];
    print('load game assets');

    add(background
      ..sprite = await loadSprite('background.png')
      ..size = size);

    cat
      ..sprite = await loadSprite('image-cat.png')
      ..size = Vector2(
          characterSize, characterSize) // Đặt kích thước cho hình ảnh cat
      ..x = -startScreen
      ..y = screenHeigth - characterSize - 10; // Đặt vị trí y cho hình ảnh cat

    // Thêm các component vào trò chơi để hiển thị
    add(cat);

    dog
      ..sprite = await loadSprite('image-dog.png')
      ..size = Vector2(characterSize, characterSize)
      ..x = screenWidth - characterSize + startScreen
      ..y = screenHeigth - characterSize;
    add(dog);

    conversation_background
      ..sprite = await loadSprite('blue-background.jpg')
      ..size = Vector2(size[0], conversationsSize)
      ..y = screenHeigth - conversationsSize;

    if (_isShowConiversation) add(conversation_background);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final screenWidth = size[0];
    final screenHeigth = size[1];

    if (dog.x != screenWidth - characterSize && cat.x != 0) {
      dog.x -= 10;
      cat.x += 10;
    } else {
      _isShowConiversation = true;
    }
  }
}
