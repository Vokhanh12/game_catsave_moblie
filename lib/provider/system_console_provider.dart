import 'package:flame_setup_tuorial/system/system_console.dart';
import 'package:flutter/foundation.dart';

class SystemConsoleProvider with ChangeNotifier {
  var _systemConsole = SystemConsole(); // Khởi tạo systemConsole ở đây

  SystemConsole get systemConsole => _systemConsole;

  // Hàm để cập nhật giá trị level_gun
  void updateLevelGun(double newValue) {
    _systemConsole.level_gun += newValue;
    notifyListeners(); // Thông báo cho các widget người tiêu dùng về sự thay đổi
  }
}
