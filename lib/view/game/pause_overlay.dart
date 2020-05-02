import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/game_state.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            child: Text(
              'Resume',
              style: TextStyle(
                color: Colors.white,
                fontSize: 64,
              ),
            ),
            onPressed: () =>
                GetIt.I<GameState>().setAction(ControlActions.TogglePause),
          ),
          FlatButton(
            child: Text(
              'Restart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 64,
              ),
            ),
            onPressed: () =>
                GetIt.I<GameState>().setAction(ControlActions.Restart),
          ),
          FlatButton(
              child: Text(
                'Scoreboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/scoreboard')),
          FlatButton(
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/settings')),
          FlatButton(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                ),
              ),
              onPressed: () {
                GetIt.I<GameState>().setAction(ControlActions.LeaveField);
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
