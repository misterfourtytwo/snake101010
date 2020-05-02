import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/game_state.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              if (GetIt.I<GameState>().score.value != 0)
                FlatButton(
                  child: Text(
                    'Resume',
                    style: TextStyle(color: Colors.white, fontSize: 64),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/game'),
                ),
              FlatButton(
                child: Text(
                  'New Game',
                  style: TextStyle(color: Colors.white, fontSize: 64),
                ),
                onPressed: () => Navigator.of(context).pushNamed('/game'),
              ),
              FlatButton(
                child: Text(
                  'Scoreboard',
                  style: TextStyle(color: Colors.white, fontSize: 64),
                ),
                onPressed: () => Navigator.of(context).pushNamed('/scoreboard'),
              ),
              FlatButton(
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 64),
                ),
                onPressed: () => Navigator.of(context).pushNamed('/settings'),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }
}
