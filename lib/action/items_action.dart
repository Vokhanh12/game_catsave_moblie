import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';

class ItemAction extends SpriteComponent with HasGameRef {
  Direction direction = Direction.left;
  String? _imageUrl;
  double? _sizeItem;

  late double x1, y1;
  late double x2, y2;

  ItemAction(this._imageUrl, this._sizeItem);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('$_imageUrl');
    size = Vector2(_sizeItem!, _sizeItem!);
    this.anchor = Anchor.center;

    // Đặt vị trí của đối tượng ở cuối bên phải của màn hình
    position =
        Vector2(gameRef.size.x - _sizeItem!, gameRef.size.y / 2 - _sizeItem!);
  }

  @override
  void update(double dt) {
    super.update(dt);
    RunRock(dt);
  }

  void RunRock(double dt) {
    if (direction == Direction.left) {
      position.x -= 25 * dt;
      x1 = position.x;
      x2 = position.x + _sizeItem!;
    }
  }

  String get getImage => _imageUrl!;
  double get getSize => _sizeItem!;
}
