import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flutter/material.dart';

class Ammo extends SpriteComponent with HasGameRef {
  Ammo() : super(size: Vector2.all(100.0));
  Direction direction = Direction.right;

  bool isCollidingWithBoss = false; // Thêm thuộc tính này

  final double characterSize = 20;
  late double x1, y1;
  late double x2, y2;

  int? decore_ammo_value; // 0: red  1: green

  @override
  Future<void> onLoad() async {
    super.onLoad();

    this.sprite = await gameRef.loadSprite('image-ammo-red.png');

    size = Vector2(characterSize, characterSize);
    this.anchor = Anchor.center;

    x1 = position.x;
    y1 = position.y;
    x2 = position.x + characterSize;
    y2 = position.y + characterSize;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }

  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, characterSize, characterSize);

    final paint = Paint()
      ..color = Colors.green // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    //move ammo
    runAmmo(dt);
    //remove ammo
  }

  //function for move ammo run on the screen
  void runAmmo(double dt) {
    if (direction == Direction.right) {
      position.x += 400 * dt;
      angle += 5;
      x1 = position.x;
      x2 = position.x + characterSize;

      if (isCollidingWithBoss) {
        // Xóa ammo nếu va chạm với model_boss
        gameRef.remove(this);
      }
    }
  }
}
