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
  final double characterSize = 200;
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
      ..y = screenHeigth - characterSize; // Đặt vị trí y cho hình ảnh cat

    // Thêm các component vào trò chơi để hiển thị
    add(cat);

    dog
      ..sprite = await loadSprite('image-dog.png')
      ..size = Vector2(characterSize, characterSize)
      ..x = screenWidth - characterSize
      ..y = screenHeigth - characterSize;
    add(dog);
  }
}
