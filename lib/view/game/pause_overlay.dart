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
        children: [
          Expanded(
            child: FlatButton(
              child: FittedBox(
                child: Text(
                  ' Continue ',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              onPressed: () =>
                  GetIt.I<GameState>().setAction(ControlActions.TogglePause),
            ),
          ),
          Expanded(
            child: FlatButton(
              child: FittedBox(
                child: Text(
                  '  Restart ',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              onPressed: () =>
                  GetIt.I<GameState>().setAction(ControlActions.Restart),
            ),
          ),
          Expanded(
            child: FlatButton(
                child: FittedBox(
                  child: Text(
                    'Scoreboard',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/scoreboard')),
          ),
          Expanded(
            child: FlatButton(
                child: FittedBox(
                  child: Text(
                    ' Settings ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed('/settings')),
          ),
          Expanded(
            child: FlatButton(
                child: FittedBox(
                  child: Text(
                    '   Menu   ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () {
                  GetIt.I<GameState>().setAction(ControlActions.LeaveField);
                  Navigator.of(context).pushReplacementNamed('/menu');
                }),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
