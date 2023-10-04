import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class StoryGame extends FlameGame {
  SpriteComponent dog = SpriteComponent();
  SpriteComponent cat = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  SpriteComponent conversation_background = SpriteComponent();
  TextPaint dialogTextPaint = TextPaint();
  DialogButton? dialogButtonNext;
  final Vector2 buttonSize = Vector2(80.0, 80.0);

  bool _isShowConiversation = false;
  bool _conversationAdded = false; // Add this flag
  final double characterSize = 220.0;
  final double startScreen = 150;
  final double conversationsSize = 100;
  int dialogLevel = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final screenWidth = size[0];
    final screenHeigth = size[1];
    print('load story game assets');
    // Initialize FlameAudio

    // Load and play background music
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('music-1.mp3');
    dialogButtonNext = DialogButton(this);

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

    dialogButtonNext!
      ..sprite = await loadSprite('button-next.png')
      ..size = buttonSize
      ..position = Vector2(
          size[0] - buttonSize[0] - startScreen, size[1] - buttonSize[1] - 10);
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
      dialogLevel = 1;
      add(conversation_background);
      add(dialogButtonNext!);
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
            canvas,
            'Báo mèo:\n Hey chó, tao có một vấn đề cần hỏi mày đấy! ',
            Vector2(startScreen + 5, size[1] - 90));
        break;

      case 2:
        dialogTextPaint.render(canvas, 'Sư tử chó:\n Ừ, mày hỏi đi.',
            Vector2(startScreen + 5, size[1] - 90));
        break;

      case 3:
        dialogTextPaint.render(
            canvas,
            'Báo mèo: Tao đã thấy thằng chủ mình \n mất tiêu suốt mấy ngày nay.\n Mày có biết nguyên nhân không?',
            Vector2(startScreen + 5, size[1] - 90));
        break;

      case 4:
        dialogTextPaint.render(
            canvas,
            'Sư tử chó: Tao thấy chủ mày đang bị xe bắt chó \n bắt đi rồi!',
            Vector2(startScreen + 5, size[1] - 90));
        break;

      case 5:
        dialogTextPaint.render(
            canvas,
            'Báo mèo: Xe bắt chó?! Đó là điều kỳ quái \n nhất mà tao từng nghe. Chắc chắn mày \n ra chuyện rồi đấy!',
            Vector2(startScreen + 5, size[1] - 90));
        break;

      case 6:
        dialogTextPaint.render(
            canvas,
            'Báo mèo: Thôi được tao sẽ đi giải cứu',
            Vector2(startScreen + 5, size[1] - 90));
        break;
      case 7:
        break;
    }
  }
}

class DialogButton extends SpriteComponent with TapCallbacks {
  final StoryGame game;

  DialogButton(this.game);

  @override
  bool onTapDown(TapDownEvent event) {
    try {
      // Thực hiện công việc tại đây (nếu cần)
      game.dialogLevel++;

      switch (game.dialogLevel) {
        case 3:
          game.loadSprite('image-cat1.png').then((sprite) {
            game.cat.sprite = sprite;
          });
          break;
        case 6:
          game.loadSprite('image-cat-2.png').then((sprite) {
            game.cat.sprite = sprite;
          });
          break;
        // Thêm các trường hợp khác ở đây nếu cần
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
