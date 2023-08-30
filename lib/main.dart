import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  SpriteComponent dog = SpriteComponent();
  SpriteComponent cat = SpriteComponent();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('load game assets');

    //load cat
    cat
      ..sprite = await loadSprite('image-cat.jpg')
      ..size = Vector2(300, 300) // Đặt kích thước cho hình ảnh cat
      ..x = 100 // Đặt vị trí x cho hình ảnh cat
      ..y = 100; // Đặt vị trí y cho hình ảnh cat

    // Thêm các component vào trò chơi để hiển thị
    add(cat);
  }
}
