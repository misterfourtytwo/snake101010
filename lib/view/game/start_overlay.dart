import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/game_state.dart';

class StartOverlay extends StatelessWidget {
  const StartOverlay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GetIt.I<GameState>().start,
      child: Container(
        color: Colors.black54,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: FittedBox(
          child: Icon(
            Icons.play_arrow,
            size: 256,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
