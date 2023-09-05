import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/model/item.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';
import 'package:flame_setup_tuorial/weigth/direction.dart';

class PlayGame extends FlameGame {
  SpriteComponent background = SpriteComponent();
  ModelPlayer cat = new ModelPlayer();
  Item item = new Item();

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

    await add(cat);
    await add(item);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (cat.x1 > item.x1) {
      cat.direction = Direction.none;
    }
  }
}
