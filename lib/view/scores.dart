import 'package:flutter/material.dart';

class ScoresView extends StatelessWidget {
  const ScoresView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Highscores'),
      ),
    );
  }
}
