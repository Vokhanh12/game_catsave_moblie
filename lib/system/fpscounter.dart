import 'package:flame/components.dart';

class FPSCounter extends TextComponent {
  double fps = 0;

  @override
  void update(double dt) {
    super.update(dt);
    fps = 1 / dt;
    text = 'FPS: ${fps.toStringAsFixed(2)}';
  }
}
