import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';

class Item extends SpriteComponent with HasGameRef {
  Item() : super(size: Vector2.all(100.0));
  Direction direction = Direction.left;

  final double characterSize = 100;

  late double x1, y1;
  late double x2, y2;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('image-rock.png');
    size = Vector2(characterSize, characterSize);
    this.anchor = Anchor.center;

    // Đặt vị trí của đối tượng ở cuối bên phải của màn hình
    position = Vector2(
        gameRef.size.x - characterSize, gameRef.size.y / 2 - characterSize);

    x1 = position.x;
    y1 = position.y;
    x2 = position.x + characterSize;
    y2 = position.y + characterSize;
  }

  @override
  void update(double dt) {
    super.update(dt);
    RunRock(dt);
  }

  void RunRock(double dt) {
    if (direction == Direction.left) {
      position.x -= 25 * dt;
      angle += 3;
      x1 = position.x;
      x2 = position.x + characterSize;
    }
  }
}
