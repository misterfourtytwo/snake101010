import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/game_state.dart';

class GoOverlay extends StatelessWidget {
  const GoOverlay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'You died.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
          ),
        ),
        Text(
          'Restart?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Y',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                  )),
              onPressed: GetIt.I<GameState>().reset,
            ),
            Text(
              '/',
              style: TextStyle(
                color: Colors.white,
                fontSize: 64,
              ),
            ),
            FlatButton(
              child: Text('N',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                  )),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        )
      ],
    );
  }
}
