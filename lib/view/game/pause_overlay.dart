import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/widgets/menu_button.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MenuButtonWidget(
            text: ' Continue ',
            onPressed: () =>
                GetIt.I<GameState>().setAction(ControlActions.TogglePause),
          ),
          MenuButtonWidget(
            text: '  Restart ',
            onPressed: () =>
                GetIt.I<GameState>().setAction(ControlActions.Restart),
          ),
          MenuButtonWidget(
              text: 'Scoreboard',
              onPressed: () => Navigator.of(context).pushNamed('/scoreboard')),
          MenuButtonWidget(
              text: ' Settings ',
              onPressed: () => Navigator.of(context).pushNamed('/settings')),
          MenuButtonWidget(
              text: '   Menu   ',
              onPressed: () {
                GetIt.I<GameState>().setAction(ControlActions.LeaveField);
                Navigator.of(context).pop();
                // pushNamedAndRemoveUntil(
                //     '/menu', (route) => route.isFirst);
              }),
        ],
      ),
    );
  }
}
