import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';

class Item extends SpriteComponent with HasGameRef {
  Item(ModelPlayer cat) : super(size: Vector2.all(100.0)) {
    _catModel = cat;
  }
  Direction direction = Direction.left;

  ModelPlayer? _catModel;

  final double characterSize = 27;

  late double x1, y1;
  late double x2, y2;

  late double playerX;
  late double playerY;
  late double itemX;
  late double itemY;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = gameRef.size[0];
    final screenHeigth = gameRef.size[1];

    sprite = await gameRef.loadSprite('image-lonnuoc.png');
    size = Vector2(characterSize, characterSize);
    this.anchor = Anchor.center;

    // Đặt vị trí của đối tượng ở cuối bên phải của màn hình
    this.position.x = screenWidth - (characterSize + 135);
    this.position.y = screenHeigth - (characterSize + 40);

    x1 = position.x;
    y1 = position.y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    Attack(dt, this);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }

  void Attack(double dt, Item item) {
    playerX = -100;
    playerY = _catModel!.position.y;
    print('playerX: $playerX');
    print('playerY:$playerY');
    itemX = item.position.x;
    itemY = item.position.y;
    print('itemX: $itemX');
    print('itemY:$itemY');

    // Thời gian cần để di chuyển từ (x0, y0) đến (x1, y1)
    double totalTime = 2; // Giây

// Vận tốc theo hướng x và y
    double vx = (playerX - itemX) / totalTime;
    double vy = (playerY - itemY) / totalTime;

    // Di chuyển đối tượng
    double deltaX = vx * dt;
    double deltaY = vy * dt;

    // Cập nhật vị trí
    playerX -= 5 * dt;
    playerY -= 5 * dt;
    item.position.x += deltaX;
    item.position.y += deltaY;
  }

  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, characterSize, characterSize);

    final paint = Paint()
      ..color = Color.fromARGB(255, 0, 255, 170) // Màu sắc của khung va chạm
      ..style = PaintingStyle.stroke // Chế độ vẽ khung
      ..strokeWidth = 2.0; // Độ dày của đường viền

    canvas.drawRect(hitbox, paint);
  }

  void RunRock(double dt) {
    if (direction == Direction.left) {
      position.x -= 25 * dt;
      x1 = position.x;
      x2 = position.x + characterSize;
    }
  }

  //Getter and Setter
  void set catModel(ModelPlayer? cat) {
    _catModel = cat;
  }
}
