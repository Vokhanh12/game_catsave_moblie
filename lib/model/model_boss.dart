import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/weigth/direction.dart';

class ModelBoss extends SpriteComponent with HasGameRef {
  ModelBoss() : super(size: Vector2.all(100.0));

  Direction direction = Direction.none;

  final double characterSize = 200;

  late double x1, y1;
  late double x2, y2;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('image-boss-right.png');
    size = Vector2(characterSize + 100, characterSize);
    position.x = size[0] + characterSize + 70;
    position.y = size[1];
    x1 = position.x;
    y1 = position.y;
    x2 = position.x + characterSize;
    y2 = position.y + characterSize;
  }
}
