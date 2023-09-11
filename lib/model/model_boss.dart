import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/ammo.dart';
import 'package:flame_setup_tuorial/model/handboss.dart';
import 'package:flame_setup_tuorial/model/item.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';
import 'package:flutter/material.dart';

class ModelBoss extends SpriteComponent with HasGameRef {
  ModelBoss() : super(size: Vector2.all(100.0));

  ModelPlayer? _catModel;

  List<Item> activeItems = [];

  Direction direction = Direction.none;

  final double characterSize = 200;

  late double x1, y1;
  late double x2, y2;

  //start point
  late double playerX, playerY;
  //end point
  late double itemX, itemY;

  double elapsedTime = 0; // Biến thời gian đã trôi qua

  HandBoss handboss = HandBoss();
  double SPEEDHAND = 0.5;

  bool turnHand = true; //if true rotate left falase rotate right
  bool rotateItem =
      true; //true is rotate item Left , falase is rotate item right

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

    add(handboss);

    //get point for player
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
    //rotateHand(dt);
    //getItemsWithHand();

    // Cập nhật thời gian đã trôi qua
    elapsedTime += dt;

    // Tạo một rock mới sau mỗi 3 giây

    Item newItems = new Item(_catModel!);

    if (elapsedTime >= 3) {
      spawn_attackAmmo(dt, newItems);

      print('Spawn Item');
      elapsedTime = 0; // Đặt lại thời gian đã trôi qua
    } else {}
  }

  spawn_attackAmmo(double dt, Item newItems) {
    add(newItems);
    activeItems.add(newItems); // Add the Item to the list
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
    if (turnHand) {
      handboss.angle += SPEEDHAND * dt;
      handboss.x2 -= SPEEDHAND;

      if (handboss.x2 < 162)
        handboss.y2 -= SPEEDHAND;
      else
        handboss.y2 += SPEEDHAND;

      if (handboss.angle > 0.6) turnHand = false;
    } else {
      handboss.angle -= SPEEDHAND * dt;
      handboss.x2 += SPEEDHAND;

      if (handboss.x2 > 162)
        handboss.y2 -= SPEEDHAND;
      else
        handboss.y2 += SPEEDHAND;

      if (handboss.angle < -0.6) turnHand = true;
    }
  }

  /*void getItemsWithHand() {
    item.x = handboss.x2;
    item.y = handboss.y2;
  }
  */

  //Getter and Setter
  void set catModel(ModelPlayer? cat) {
    _catModel = cat;
  }
}
