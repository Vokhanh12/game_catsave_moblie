import 'dart:async'; // Import thư viện thời gian

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/action/items_action.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/model_boss.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';
import 'package:flame_setup_tuorial/system/fpscounter.dart';

class PlayGame extends FlameGame {
  SpriteComponent background = SpriteComponent();
  ModelPlayer cat = ModelPlayer();
  ModelBoss boss_dog = ModelBoss();

  ItemAction item_rock1 = ItemAction('iamge-rock.png', 50);
  ItemAction item_rock2 = ItemAction('item-rock2.png', 50);
  FPSCounter fpsCounter = FPSCounter(); // Thêm FPSCounter như một thành phần
  double elapsedTime = 0; // Biến thời gian đã trôi qua

  onArrowKeyChanged(Direction direction) {
    cat.direction = direction;
  }

  void spawnItem(double value_y) async {
    final ItemAction item_lonnuoc = ItemAction('image-lonnuoc.png', 50);
    await add(item_lonnuoc);
    item_lonnuoc.y = value_y;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final screenWidth = size[0];
    final screenHeight = size[1];
    print('load play game assets');

    //Pass Player through Boss
    boss_dog.catModel = cat;

    add(background
      ..sprite = await loadSprite('background.gif')
      ..size = size);

    fpsCounter..position.y += 20;

    add(fpsCounter); // Thêm FPSCounter vào trò chơi

    await add(cat);

    await add(boss_dog);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Kiểm tra va chạm giữa ammo và model_boss
    boss_dog.checkCollisionWithAmmos(cat.activeAmmos);

    // Cập nhật model_boss
    boss_dog.update(dt);
  }
}
