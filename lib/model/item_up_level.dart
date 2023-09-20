import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';

class ItemUpLevel extends SpriteComponent with HasGameRef {
  ItemUpLevel() : super(size: Vector2.all(100));
  final double characterSize = 40.0;

  // Used to go to left in the screen
  Direction direction = Direction.left;

  Random random = Random();

  bool isCollidingWithPlayer = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final SCREEN_WIDTH_MOBLIE = gameRef.size[0];
    final SCREEN_HEIGTH_MOBLIE = gameRef.size[1];

    this.sprite = await gameRef.loadSprite('image_up_level_gun.png');
    size = Vector2(characterSize, characterSize);
    this.anchor = Anchor.center;

    // Đặt vị trí của đối tượng ở cuối bên phải của màn hình
  }

  void update(double dt) {
    super.update(dt);

    //run item_up_level
    run(70.0, dt);
  }

  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }

  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, characterSize, characterSize);

    final paint = Paint()
      ..color = Color.fromARGB(255, 208, 255, 0) // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }

  void run(double speed, double dt) {
    this.position.x -= speed * dt;

    if (isCollidingWithPlayer) {
      gameRef.remove(this);
    }
  }
}
