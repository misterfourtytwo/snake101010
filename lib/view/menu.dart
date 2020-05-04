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
                Expanded(
                  child: FlatButton(
                    child: FittedBox(
                      child: Text(
                        ' Continue ',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/game', arguments: false),
                  ),
                ),
              Expanded(
                child: FlatButton(
                  child: FittedBox(
                    child: Text(
                      ' New Game ',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/game', arguments: true),
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: FittedBox(
                    child: Text(
                      'Scoreboard',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/scoreboard'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: FittedBox(
                    child: Text(
                      ' Settings ',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/settings'),
                ),
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
