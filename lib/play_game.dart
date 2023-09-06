import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/model/item.dart';
import 'package:flame_setup_tuorial/model/model_boss.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';
import 'package:flame_setup_tuorial/system/fpscounter.dart';
import 'package:flame_setup_tuorial/weigth/direction.dart';

class PlayGame extends FlameGame {
  SpriteComponent background = SpriteComponent();
  ModelPlayer cat = ModelPlayer();
  ModelBoss boss_dog = ModelBoss();
  Item rock = Item();
  FPSCounter fpsCounter = FPSCounter(); // Thêm FPSCounter như một thành phần

  onArrowKeyChanged(Direction direction) {
    cat.direction = direction;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final screenWidth = size[0];
    final screenHeight = size[1];
    print('load play game assets');

    add(background
      ..sprite = await loadSprite('background.gif')
      ..size = size);

    fpsCounter..position.y += 20;

    add(fpsCounter); // Thêm FPSCounter vào trò chơi

    await add(cat);

    await add(rock);

    await add(boss_dog);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (rock.x <= 100) {
      if (contains(rock)) {
        remove(rock);
        print("Remove the rock");
      }
    } else {
      rock.x -= 50 * dt;
      rock.angle -= 1 * dt;
    }
  }
}
