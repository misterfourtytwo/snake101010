import 'package:flutter/material.dart';

import 'package:snake101010/exports.dart';
import 'package:snake101010/providers/config.dart';
import 'package:snake101010/view/game/bar.dart';
import 'package:snake101010/view/game/controls.dart';
import 'package:snake101010/view/game/field.dart';
import 'package:snake101010/view/game/go_overlay.dart';
import 'package:snake101010/view/game/pause_overlay.dart';
import 'package:snake101010/view/game/start_overlay.dart';
import 'package:snake101010/widgets/game_controls.dart';

class GameView extends StatelessWidget {
  const GameView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = sl<Config>();
    final stateProvider = sl<GameStateProvider>();

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: ControlsWidget(
            child: OrientationBuilder(
              builder: (context, orientation) {
                // config.size = size.biggest;
                config.size = MediaQuery.of(context).size;
                if (Orientation.landscape == orientation)
                  return Stack(
                    children: [
                      GameField(),
                      GameBar(),
                    ],
                  );
                else
                  return Stack(children: [
                    GameField(),
                    GameBar(),
                    if (config.drawControls) GameControls(),
                    if (stateProvider.snake.isDead)
                      GoOverlay()
                    else if (stateProvider.awaitingStart)
                      StartOverlay()
                    else if (stateProvider.paused)
                      PauseOverlay()
                  ]);
              },
            ),
          ),
        ));
  }
}
