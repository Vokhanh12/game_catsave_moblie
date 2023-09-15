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
        body: Builder(builder: (context) {
          final game = PlayGame(context);
          final syscp = Provider.of<SystemConsoleProvider>(context);

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
                    child: Text('Level: ${syscp.systemConsole.level_gun}')),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Builder(
                    builder: (context) {
                      return ElevatedButton(
                        child: Text('Test'),
                        onPressed: () => syscp.updateLevelGun(10),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 40, top: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: HeartPlayerProgressBar(
                    value: syscp.systemConsole.heart_player,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    ),
  ));
}
