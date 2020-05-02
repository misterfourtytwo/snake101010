import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/utils/controls_widget.dart';
import 'package:snake101010/view/game/bar.dart';
import 'package:snake101010/view/game/field.dart';
import 'package:snake101010/view/game/go_overlay.dart';
import 'package:snake101010/view/game/pause_overlay.dart';

class GameView extends StatelessWidget {
  const GameView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = GetIt.I<Config>();
    final state = GetIt.I<GameState>();

    return Scaffold(
        // backgroundColor: config.bgColor,
        body: SafeArea(
      child: LayoutBuilder(
        builder: (context, size) {
          config.size = size.biggest;

          return ControlsWidget(
            child: Stack(children: [
              GameField(),
              GameBar(),
              // if (config.drawControls) GameControls(),
              if (state.snake.dead)
                GoOverlay()
              else if (state.paused)
                PauseOverlay()
            ]),
          );
        },
      ),
    ));
  }
}
