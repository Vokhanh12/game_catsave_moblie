
import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/ammo.dart';
import 'package:flame_setup_tuorial/model/item.dart';
import 'package:flame_setup_tuorial/model/item_up_heart.dart';
import 'package:flame_setup_tuorial/model/item_up_level.dart';
import 'package:flame_setup_tuorial/provider/system_console_provider.dart';
import 'package:flame_setup_tuorial/system/system_config.dart';
import 'package:flutter/material.dart';

import '../class/point.dart';

class ModelPlayer extends SpriteComponent with HasGameRef {
  final SystemConsoleProvider systemConsoleProvider;

  ModelPlayer({required this.systemConsoleProvider})
      : super(size: Vector2.all(100.0));
  List<Ammo> activeAmmos = [];
  Direction direction = Direction.none;
  bool hasFlippedHorizontally = false;
  final double characterSize = 100;
  late double x1, y1;
  late double x2, y2;

  double elapsedTime = 0; // Biến thời gian đã trôi qua

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeigth = size[1];

    sprite = await gameRef.loadSprite('character_cat.png');
    this.anchor = Anchor.center;
    this.flipHorizontally();
    size = Vector2(characterSize, characterSize);
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);

    updatePosition(dt);
    Point incPoint = new Point(this.position.x, this.position.y);
    systemConsoleProvider.systemConsole.pointPlayer = incPoint;

    // Cập nhật thời gian đã trôi qua
    elapsedTime += dt;

    // Tạo một rock mới sau mỗi 3 giây

    if (elapsedTime >= SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER) {
      spawn_attackAmmo(dt);
      print('width: ${gameRef.size[0]} heigth: ${gameRef.size[1]}');
      elapsedTime = 0; // Đặt lại thời gian đã trôi qua
    } else {
      remove_attackAmmoByBoss(dt);
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

  spawn_attackAmmo(double dt) {
    final Ammo newAmmo = Ammo();
    newAmmo.y = position.y + characterSize * 2.2 / 7;
    newAmmo.x = position.x + 25;
    gameRef.add(newAmmo);
    activeAmmos.add(newAmmo); // Add the ammo to the list
  }

  void remove_attackAmmoByBoss(double dt) {
    List<Ammo> ammosToRemove = [];
    for (final ammo in activeAmmos) {
      if (ammo.position.x > gameRef.size[0]) {
        ammosToRemove.add(ammo);
        print('Remove ammo off the screen or colliding with boss');
      } else if (ammo.isCollidingWithBoss) {
        ammosToRemove.add(ammo);

        systemConsoleProvider.updateHeartBoss();

        print('Remove ammo colliding the boss');
      }
    }
    activeAmmos.removeWhere((ammo) => ammosToRemove.contains(ammo));
  }

  void checkCollisionWithItems(List<Item> items)
  {
    print('Test Item: ${items}');

    for (final item in items) {
      if (item.toRect().overlaps(toRect())) {
        item.isCollidingWithPlayer = true;
      }
    }
  }

  void checkCollisionWithItemsUpLevel(List<ItemUpLevel> itemsUpLevel)
  {
    for (final itemUpLevel in itemsUpLevel) {
      if (itemUpLevel.toRect().overlaps(toRect())) 
        itemUpLevel.isCollidingWithPlayer = true;
    }
  }

  void checkCollisionWithItemUpHeart(List<ItemUpHeart> itemsUpHeart)
  {
    for(final itemUpHeart in itemsUpHeart)
    {
      if(itemUpHeart.toRect().overlaps(toRect()))
      itemUpHeart.isCollidingWithPlayer = true;

    }
  }


  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y -= 200 * dt;
        y1 = position.y;
        y2 = position.y + characterSize;
        break;
      case Direction.down:
        position.y += 200 * dt;
        y1 = position.y;
        y2 = position.y + characterSize;
        break;
      case Direction.left:
        position.x -= 200 * dt;
        x1 = position.x;
        x2 = position.x + characterSize;

        break;
      case Direction.right:
        position.x += 200 * dt;
        x1 = position.x;
        x2 = position.x + characterSize;
        break;
      case Direction.none:
        break;
    }
  }
}
