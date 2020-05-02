import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/models/scoreboard.dart';
import 'package:snake101010/providers/game_state.dart';

class ScoreboardView extends StatelessWidget {
  const ScoreboardView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scores = GetIt.I<ScoreBoard>()
        .getScores(current: Score(value: GetIt.I<GameState>().score.value));
    List<TextSpan> lines = [];
    final maxLen =
        scores.fold(0, (int maxLen, e) => max(maxLen, e.toString().length)) + 1;
    for (int i = 0; i < scores.length; i++)
      lines.add(TextSpan(
          text:
              '$i.${scores[i].playerName}:${' ' * (maxLen - scores[i].toString().length)}${scores[i].value}\n'));
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black87,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Text(
                'Scoreboard',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              flex: 3,
              child: FittedBox(
                child: RichText(
                  maxLines: scores.length,
                  text: TextSpan(
                    children: lines,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ),
            FlatButton(
                child: FittedBox(
                  child: Text(
                    '   Back   ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ));
  }
}
