import 'package:flutter/material.dart';
import 'package:snake101010/view/game/view.dart';
import 'package:snake101010/view/scores.dart';
import 'package:snake101010/view/settings.dart';

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
              FlatButton(
                child: Text(
                  'PLAY',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GameView())),
              ),
              FlatButton(
                child: Text(
                  'Scoreboard',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScoresView()),
                ),
              ),
              FlatButton(
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsView()),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
