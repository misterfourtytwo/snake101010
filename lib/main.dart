import 'package:flutter/material.dart';

import 'package:snake101010/game.dart';

void main() {
  runApp(Snake());
}

class Snake extends StatelessWidget {
  const Snake({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Snake",
      home: Menu(),
      color: Colors.black,
      theme: ThemeData(
        primaryColor: Colors.black,
        // primarySwatch: Colors.black,
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

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
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GameScreen())),
              ),
              FlatButton(
                child: Text(
                  'Highscore',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('highscore'),
                          ),
                        ))),
              ),
              FlatButton(
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 48),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('settings'),
                          ),
                        ))),
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
