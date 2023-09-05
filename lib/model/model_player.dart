import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/weigth/direction.dart';

class ModelPlayer extends SpriteComponent with HasGameRef {
  ModelPlayer() : super(size: Vector2.all(100.0));

  Direction direction = Direction.none;

  final double characterSize = 100;

  late double x1, y1;
  late double x2, y2;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('image-lonnuoc.png');
    size = Vector2(characterSize, characterSize);
    position = gameRef.size / 2;
    x1 = position.x;
    y1 = position.y;
    x2 = position.x + characterSize;
    y2 = position.y + characterSize;
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y -= 10;
        y1 = position.y;
        y2 = position.y + characterSize;
        break;
      case Direction.down:
        position.y += 10;
        y1 = position.y;
        y2 = position.y + characterSize;
        break;
      case Direction.left:
        position.x -= 10;
        x1 = position.x;
        x2 = position.x + characterSize;
        break;
      case Direction.right:
        position.x += 10;
        x1 = position.x;
        x2 = position.x + characterSize;
        break;
      case Direction.none:
        break;
    }
  }
}
