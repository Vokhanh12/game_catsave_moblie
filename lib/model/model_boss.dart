import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/ammo.dart';
import 'package:flame_setup_tuorial/model/handboss.dart';
import 'package:flame_setup_tuorial/model/item.dart';
import 'package:flutter/material.dart';

class ModelBoss extends SpriteComponent with HasGameRef {
  ModelBoss() : super(size: Vector2.all(100.0));

  Direction direction = Direction.none;

  final double characterSize = 200;

  late double x1, y1;
  late double x2, y2;

  HandBoss handboss = HandBoss();
  Item item = Item();

  bool turn = true; //if true rotate left falase rotate right

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await gameRef.loadSprite('dog-boss-right.png');
    size = Vector2(characterSize + 100, characterSize);

    position.x = size[0] + characterSize + 70;
    position.y = size[1];

    x1 = position.x;
    y1 = position.y;
    x2 = position.x + characterSize;
    y2 = position.y + characterSize;
    add(item);
    add(handboss);
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
    rotateHand(dt);
    getItemsWithHand(dt);
  }

  //check collision Ammos
  void checkCollisionWithAmmos(List<Ammo> ammos) {
    for (final ammo in ammos) {
      if (ammo.toRect().overlaps(toRect())) {
        ammo.isCollidingWithBoss = true;
      }
    }
  }

  void rotateHand(double dt) {
    if (turn) {
      handboss.angle += 0.5 * dt;
      handboss.x2 += handboss.angle;
      handboss.y2 += handboss.angle;
      print('${handboss.angle}');
      print('X hand:${handboss.x2}');
      print('Y hand:${handboss.y2}');
      if (handboss.angle > 0.8) turn = false;
    } else {
      handboss.angle -= 0.5 * dt;
      handboss.x2 -= handboss.angle;
      handboss.y2 -= handboss.angle;
      print('${handboss.angle}');
      print('X hand:${handboss.x2}');
      print('Y hand:${handboss.y2}');
      if (handboss.angle < -0.6) turn = true;
    }
  }

  void getItemsWithHand(double dt) {
    void getItemsWithHand() {
      // Lấy vị trí và góc quay của handboss
      final double handX = handboss.x;
      final double handY = handboss.y;
      final double angle = handboss.angle;

      // Tính toán vị trí mới của item dựa trên vị trí và góc quay của handboss,
      // cộng thêm khoảng cách width và height
      final double width = 100.0; // Thay bằng giá trị width mong muốn
      final double height = 100.0; // Thay bằng giá trị height mong muốn

      final double itemX = handX + width * cos(angle);
      final double itemY = handY + height * sin(angle);

      // Cập nhật vị trí của item
      item.position.x = itemX;
      item.position.y = itemY;
    }
  }
}
