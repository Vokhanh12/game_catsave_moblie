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
  TextPaint dialogTextPaint = TextPaint();
  bool _isShowConiversation = false;
  bool _conversationAdded = false; // Add this flag
  final double characterSize = 220.0;
  final double startScreen = 150;
  final double conversationsSize = 100;
  int dialogLevel = 1;

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
      ..size = Vector2(characterSize, characterSize)
      ..x = -startScreen
      ..y = screenHeigth - characterSize - 10;

    add(cat);

    dog
      ..sprite = await loadSprite('image-dog.png')
      ..size = Vector2(characterSize, characterSize)
      ..x = screenWidth - characterSize + startScreen
      ..y = screenHeigth - characterSize;
    add(dog);

    conversation_background
      ..sprite = await loadSprite('blue-background.jpg')
      ..size = Vector2(size[0] - startScreen * 2, conversationsSize)
      ..x = startScreen
      ..y = screenHeigth - conversationsSize;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final screenWidth = size[0];

    if (dog.x != screenWidth - characterSize && cat.x != 0) {
      dog.x -= 10;
      cat.x += 10;
    } else if (!_conversationAdded) {
      // Check if the conversation is not added yet
      add(conversation_background);
      _conversationAdded =
          true; // Set the flag to true to prevent further additions
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch (dialogLevel) {
      case 1:
        dialogTextPaint.render(
            canvas, 'helloworld', Vector2(startScreen + 5, size[1] - 80));
        break;
    }
  }
}
