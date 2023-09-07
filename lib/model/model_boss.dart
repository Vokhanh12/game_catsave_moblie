import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/ammo.dart';
import 'package:flutter/material.dart';

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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }

  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, characterSize, characterSize);

    final paint = Paint()
      ..color = Colors.blue // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void checkCollisionWithAmmos(List<Ammo> ammos) {
    for (final ammo in ammos) {
      if (ammo.toRect().overlaps(toRect())) {
        ammo.isCollidingWithBoss = true;
      }
    }
  }
}
