import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HandBoss extends SpriteComponent with HasGameRef {
  final double WIDTH = 20;
  final double HEIGTH = 45;

  late double x1, y1;
  late double x2, y2;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    this.sprite = await gameRef.loadSprite('image-hand-dog.png');
    this.size = Vector2(WIDTH, HEIGTH);
    this.anchor = Anchor.topCenter;

    this.position.x = 162;
    this.position.y = 80;

    x1 = position.x;
    y1 = position.y;
    x2 = position.x + WIDTH;
    y2 = position.y + HEIGTH;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }

  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, WIDTH, HEIGTH);

    final paint = Paint()
      ..color = Color.fromARGB(255, 197, 0, 223) // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
