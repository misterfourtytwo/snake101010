import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:snake101010/widgets/menu_button.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Offstage(
                offstage: GetIt.I<GameState>().score.value == 0,
                child: MenuButtonWidget(
                  text: ' Continue ',
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/game', arguments: false),
                ),
              ),
              MenuButtonWidget(
                text: ' New Game ',
                onPressed: () =>
                    Navigator.of(context).pushNamed('/game', arguments: true),
              ),
              MenuButtonWidget(
                text: 'Scoreboard',
                onPressed: () => Navigator.of(context).pushNamed('/scoreboard'),
              ),
              MenuButtonWidget(
                text: ' Settings ',
                onPressed: () => Navigator.of(context).pushNamed('/settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
