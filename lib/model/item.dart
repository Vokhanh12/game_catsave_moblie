import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_setup_tuorial/class/direction.dart';
import 'package:flame_setup_tuorial/logic/phuongtrinhbacmot.dart';
import 'package:flame_setup_tuorial/model/model_player.dart';

class Item extends SpriteComponent with HasGameRef {
  Item(ModelPlayer cat) : super(size: Vector2.all(100.0)) {
    _catModel = cat;
  }
  Direction direction = Direction.left;

  ModelPlayer? _catModel;

  bool isCollidingWithPlayer = false; // Thêm thuộc tính này

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
    playerX = _catModel!.position.x;
    playerY = _catModel!.position.y;

    sprite = await gameRef.loadSprite('image-lonnuoc.png');
    size = Vector2(characterSize, characterSize);
    this.anchor = Anchor.center;

    // Đặt vị trí của đối tượng ở cuối bên phải của màn hình
    this.position.x = screenWidth - (characterSize + 135);
    this.position.y = screenHeigth - (characterSize + 40);

    x1 = position.x;
    y1 = position.y;
  }

  void update(double dt) {
    super.update(dt);
    updatePlayerXAndY();
    Attack(dt, this);
  }

  void render(Canvas canvas) {
    super.render(canvas);

    // Vẽ hình ảnh hoặc sprite bình thường ở đây

    renderDebug(canvas); // Gọi hàm renderDebug để vẽ khung va chạm
  }

  Future<void> updatePlayerXAndY() async {
    await Future.delayed(Duration(seconds: 3));
    playerX = _catModel!.position.x;
    playerY = _catModel!.position.y;
  }

  void Attack(double dt, Item item) {
    itemX = item.position.x;
    itemY = item.position.y;

    //Tính hệ số góc m:
    double m = (playerY - itemY) / (playerX - itemX);

    //Sử dụng hệ số góc m  ti`m b
    //yA = mxA + b
    //sử dụng điểm item

    double b = itemY - (m * itemX);

    PhuongTrinhBacMot ptbm = PhuongTrinhBacMot();

    final double itemX_outside = -100;
    final double itemY_outside = ptbm.findY(m, b, itemX_outside);

    // Thời gian cần để di chuyển từ (x0, y0) đến (x1, y1)
    double totalTime = 1; // Giây
    // Thêm một hệ số trễ (delay factor)
    double delayFactor = 5; // Chỉnh giá trị này để điều chỉnh mức trễ

// Vận tốc theo hướng x và y
    double vx = (itemX_outside - itemX) / totalTime;
    double vy = (itemY_outside - itemY) / totalTime;

    // Di chuyển đối tượng
    double deltaX = vx * dt;
    double deltaY = vy * dt;
    // Cập nhật vị trí của PlayerX và PlayerY với sự trễ
    playerX += (deltaX * delayFactor);
    playerY += (deltaY * delayFactor);

    item.position.x += deltaX;
    item.position.y += deltaY;

    if (isCollidingWithPlayer) {
      // Xóa ammo nếu va chạm với model_boss
      gameRef.remove(this);
    }
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
