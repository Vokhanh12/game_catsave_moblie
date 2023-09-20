import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_setup_tuorial/class/navigationKeys.dart';
import 'package:flame_setup_tuorial/play_game.dart';
import 'package:flame_setup_tuorial/provider/system_console_provider.dart';
import 'package:flame_setup_tuorial/weigth/heart_boss_progress_bar.dart';
import 'package:flame_setup_tuorial/weigth/heart_player_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // Truyền SystemConsole vào Provider

  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();

  runApp(ChangeNotifierProvider<SystemConsoleProvider>(
    create: (_) => SystemConsoleProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          final syscp =
              Provider.of<SystemConsoleProvider>(context, listen: false);
          final game = PlayGame(syscp);

          return Stack(
            children: [
              GameWidget(
                game: game,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: NavigationKeys(
                    onDirectionChanged: game.onArrowKeyChanged,
                  ),
                ),
              ),
              //Decorate Heart the boss
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: HeartBossProgressBar(
                    value: syscp.systemConsole.heart_boss,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Selector<SystemConsoleProvider, double>(
                        selector: (context, systemConsoleProvider) =>
                            systemConsoleProvider.systemConsole.level_gun,
                        builder: (context, levelgundata, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/image_up_level_gun.png',
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Level: $levelgundata',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        })),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      child: Text('Tăng giá trị'),
                      onPressed: () {
                        // Lấy giá trị hiện tại của level_gun và cập nhật nó
                        syscp.updateLevelGun(10);
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 25),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Selector<SystemConsoleProvider, int>(
                        selector: (context, systemConsoleProvider) =>
                            systemConsoleProvider.systemConsole.hear_player,
                        builder: (context, heartPlayer, child) {
                          return HeartPlayerProgressBar(
                            value: heartPlayer,
                          );
                        })),
              ),
            ],
          );
        }),
      ),
    ),
  ));
}
