import 'package:flutter/material.dart';

import 'package:snake101010/exports.dart';
import 'package:snake101010/widgets/menu_button.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  bool showContinue;
  @override
  void initState() {
    super.initState();
    showContinue = sl<GameStateProvider>().saveEmpty;
  }

  update() {
    setState(() {
      showContinue = sl<GameStateProvider>().saveEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              if (showContinue)
                MenuButtonWidget(
                    text: ' Continue ',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/game', arguments: false);
                      update();
                    }),
              MenuButtonWidget(
                  text: ' New Game ',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/game', arguments: true);
                    update();
                  }),
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
