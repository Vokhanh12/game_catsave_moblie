import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/ammo.dart';
import 'package:flutter/material.dart';

class ModelPlayer extends SpriteComponent with HasGameRef {
  ModelPlayer() : super(size: Vector2.all(100.0));

  Direction direction = Direction.none;

  bool hasFlippedHorizontally = false;
  final double characterSize = 100;
  late double x1, y1;
  late double x2, y2;

  double elapsedTime = 0; // Biến thời gian đã trôi qua

  spawn_AttackAmmo(double dt) {
    final Ammo newAmmo = Ammo();
    newAmmo.y = position.y + characterSize * 2.2 / 3;
    newAmmo.x = position.x;
    gameRef.add(newAmmo);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('character_cat.png');
    this.flipHorizontally();
    size = Vector2(characterSize, characterSize);
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);

    // Cập nhật thời gian đã trôi qua
    elapsedTime += dt;

    // Tạo một rock mới sau mỗi 3 giây
    if (elapsedTime >= 3) {
      spawn_AttackAmmo(dt);

      elapsedTime = 0; // Đặt lại thời gian đã trôi qua
    }
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
      ..color = Colors.red // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y -= 100 * dt;
        y1 = position.y;
        y2 = position.y + characterSize;
        break;
      case Direction.down:
        position.y += 100 * dt;
        y1 = position.y;
        y2 = position.y + characterSize;
        break;
      case Direction.left:
        position.x -= 100 * dt;
        x1 = position.x;
        x2 = position.x + characterSize;

        break;
      case Direction.right:
        position.x += 100 * dt;
        x1 = position.x;
        x2 = position.x + characterSize;
        break;
      case Direction.none:
        break;
    }
  }
}
