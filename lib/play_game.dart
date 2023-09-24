import 'dart:async'; // Import thư viện thời gian
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/action/items_action.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/item_up_heart.dart';
import 'package:flame_setup_tuorial/model/item_up_level.dart';
import 'package:flame_setup_tuorial/model/model_boss.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';
import 'package:flame_setup_tuorial/provider/system_console_provider.dart';
import 'package:flame_setup_tuorial/system/fpscounter.dart';
import 'package:flame_setup_tuorial/system/system_config.dart';

class PlayGame extends FlameGame {
  SystemConsoleProvider
      systemConsoleProvider; // Thêm trường context vào PlayGame

  late ModelPlayer cat;
  late ModelBoss boss_dog;

  PlayGame(this.systemConsoleProvider) {
    cat = ModelPlayer(systemConsoleProvider: systemConsoleProvider);
    boss_dog = ModelBoss(systemConsoleProvider: systemConsoleProvider);
  }

  SpriteComponent background = SpriteComponent();

  ItemAction item_rock1 = ItemAction('iamge-rock.png', 50);
  ItemAction item_rock2 = ItemAction('item-rock2.png', 50);

  FPSCounter fpsCounter = FPSCounter(); // Thêm FPSCounter như một thành phần

  double elapsedTimeUpLevel = 0; // Biến thời gian đã trôi qua
  double elapsedTimeUpHeart = 0;

  List<ItemUpLevel> activeItemUpLevel = [];
  List<ItemUpHeart> activeItemUpHeart = [];

  Random random = Random();

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

    cat.checkCollisionWithItems(boss_dog.activeItems);

    cat.checkCollisionWithItemsUpLevel(activeItemUpLevel);

    print('${cat.activeAmmos}');

    print('${boss_dog.activeItems}');

    // Cập nhật model_boss
    boss_dog.update(dt);
    cat.update(dt);

    elapsedTimeUpLevel += dt;

    if (elapsedTimeUpLevel >= SystemConfig.TIME_SPAWN_ITEM_UP_LEVEL) {
      spawnItemUpLevel();
      elapsedTimeUpLevel = 0; // Đặt lại thời gian đã trôi qua
    } else {
      remove_getItemUpLevel(dt);
    }

    /*

    elapsedTimeUpHeart += dt;

    if (elapsedTimeUpHeart >= SystemConfig.TIME_SPAWN_TIME_UP_HEART) {
      spawnItemUpHeart();
      elapsedTimeUpHeart = 0; // Đặt lại thời gian đã trôi qua
    } else {
      remove_getItemUpHeart(dt);
    }

    */
  }

  void delaySpawnItemUpLevel(int number) {}

  void spawnItemUpLevel() {
    ItemUpLevel itemUpLevel = new ItemUpLevel();
    itemUpLevel.x = size[0];
    itemUpLevel.y = ramdomPosionY(size[1]);

    this.add(itemUpLevel);
    activeItemUpLevel.add(itemUpLevel);
  }

  void remove_getItemUpLevel(double dt) {
    List<ItemUpLevel> itemsUpLevelToRemove = [];
    for (final itemUpLevel in activeItemUpLevel) {
      if (itemUpLevel.position.x < 0) {
        itemsUpLevelToRemove.add(itemUpLevel);
        print('Remove itemUpLevel off the screen');
      } else if (itemUpLevel.isCollidingWithPlayer) {
        itemsUpLevelToRemove.add(itemUpLevel);
        systemConsoleProvider!.updateLevelGun();

        // number ammo Gun up Level max level 1 = 7
        if (SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER == 1)
          SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER = 1;
        else
          SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER -= 1;

        if (systemConsoleProvider!.systemConsole.level_gun > 8) {
          systemConsoleProvider!.systemConsole.level_gun = 8;
        }

        print('Rmove itemUplevel colliding the player');
      }
    }

    activeItemUpLevel
        .removeWhere((ammo) => itemsUpLevelToRemove.contains(ammo));
  }

  void spawnItemUpHeart() {
    ItemUpHeart itemUpItemUpHeart = new ItemUpHeart();
    itemUpItemUpHeart.x = size[0];
    itemUpItemUpHeart.y = ramdomPosionY(size[1]);

    this.add(itemUpItemUpHeart);
    activeItemUpHeart.add(itemUpItemUpHeart);
  }

  void remove_getItemUpHeart(double dt) {
    List<ItemUpHeart> itemsUpHeartToRemove = [];
    for (final itemUpHeart in activeItemUpHeart) {
      if (itemUpHeart.position.x < 0) {
        itemsUpHeartToRemove.add(itemUpHeart);
        print('Remove itemUpHeart off the screen');
      } else if (itemUpHeart.isCollidingWithPlayer) {
        itemsUpHeartToRemove.add(itemUpHeart);
        systemConsoleProvider!.updateLevelGun();

        // number ammo Gun up Level max level 1 = 7
        if (SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER == 1)
          SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER = 1;
        else
          SystemConfig.TIME_SHOOT_AMMO_BY_PLAYER -= 1;

        if (systemConsoleProvider!.systemConsole.level_gun > 8) {
          systemConsoleProvider!.systemConsole.level_gun = 8;
        }

        print('Rmove itemUpHeart colliding the player');
      }
    }

    activeItemUpLevel
        .removeWhere((ammo) => itemsUpHeartToRemove.contains(ammo));
  }

  double ramdomPosionY(double numberToRandom) {
    double rabdomNumber = random.nextDouble() * numberToRandom;

    return rabdomNumber;
  }
}
