import 'package:flame_setup_tuorial/system/system_config.dart';
import 'package:flame_setup_tuorial/system/system_console.dart';
import 'package:flutter/foundation.dart';

class SystemConsoleProvider with ChangeNotifier {
  var _systemConsole = SystemConsole(); // Khởi tạo systemConsole ở đây

  SystemConsole get systemConsole => _systemConsole;

  // Hàm để cập nhật giá trị level_gun
  void updateLevelGun() {
    increaseUpLevelGun();
    notifyListeners(); // Thông báo cho các widget người tiêu dùng về sự thay đổi
  }

  void updateHeartBoss() {
    reducedHeartBoss();
    changeStatusBoss();
    notifyListeners();
  }


  void updateAddHeartPlayer(){
    increaseHeartPlayer();
    notifyListeners();

  }

  void updateRemoveHeartPlayer(){
    reducedHeartPlayer();
    notifyListeners();

  }

  void increaseUpLevelGun() {
    _systemConsole.level_gun += SystemConfig.TIME_REMOVESHOTT_AMMO_BY_PLAYER;
  }

  void increaseHeartPlayer() {}

  void reducedHeartBoss() {
    _systemConsole.heart_boss -= SystemConfig.DAMGE_GUN;

    if (_systemConsole.heart_boss < SystemConfig.HEART_BOSS * (60 / 100))
      _systemConsole.status_attack_boss = 1;
    else if (_systemConsole.heart_boss < SystemConfig.HEART_BOSS * (30 / 100))
      systemConsole.status_attack_boss = 2;
  }

  void reducedHeartPlayer() {
    _systemConsole.hear_player -= SystemConfig.DAME_ITEM;
  }

  void changeStatusBoss() {
    switch (_systemConsole.status_attack_boss) {
      case 1:
        ChangeAttackTypeBoss(systemConsole.time_throw_item_by_boss / 2,
            _systemConsole.time_rotate_hand * 2);
        break;
      case 2:
        ChangeAttackTypeBoss(systemConsole.time_throw_item_by_boss / 3,
            _systemConsole.time_rotate_hand * 3);
        break;
    }
  }

  void ChangeAttackTypeBoss(double timethrow, double timerotate) {
    print("time rotate:$timerotate");

    SystemConfig.TIME_THROW_ITEM_BY_BOSS = timethrow;
    SystemConfig.TIME_ROTATE_HAND = timerotate;
  }
}
