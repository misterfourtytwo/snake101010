import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';

class GameBar extends StatelessWidget {
  const GameBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barHeight = GetIt.I<Config>().barHeight;
    final state = GetIt.I<GameState>();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: state.score,
            builder: (context, score, _) => Text(
              'SCORE: ${score}',
              style: TextStyle(
                color: Colors.white54,
                fontSize: barHeight * .6,
              ),
            ),
          ),
          // TODO
          // ValueListenableBuilder<bool>(
          //     valueListenable: state.snake.moving,
          //     builder: (context, moving, _) {
          //       return
          //       ///
          IconButton(
              iconSize: barHeight * .6,
              splashColor: Colors.transparent,
              icon: Icon(
                state.snake.moving ? Icons.pause : Icons.play_arrow,
                color: Colors.white54,
              ),
              onPressed: () {
                if (!state.snake.dead) state.snake.moving ^= true;
              })
          // ;
          // }),
        ],
      ),
    );
  }
}
