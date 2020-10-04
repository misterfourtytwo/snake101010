import 'dart:math';

import 'package:flutter/material.dart';

import 'package:snake101010/exports.dart';
import 'package:snake101010/models/score.dart';
import 'package:snake101010/providers/scoreboard.dart';
import 'package:snake101010/providers/state_provider.dart';

class ScoreboardView extends StatelessWidget {
  const ScoreboardView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scores = sl<ScoreBoard>().getScores(
        Score(sl<GameStateProvider>().currentScore, playerName: 'Current'));

    // make same width lines with empty space in center
    List<TextSpan> lines = [];
    final maxLen =
        scores.fold(0, (int maxLen, e) => max(maxLen, e.toString().length)) + 1;
    for (int i = 0; i < scores.length; i++)
      lines.add(TextSpan(
          text:
              '$i.${scores[i].playerName}:${' ' * (maxLen - scores[i].toString().length)}${scores[i].value}\n'));

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FittedBox(
                    child: Text(
                      'Scoreboard',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: RichText(
                          maxLines: scores.length,
                          text: TextSpan(
                            children: lines,
                            style: Theme.of(context).textTheme.headline2,
                          )),
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
              )),
        ),
      ),
    );
  }
}
