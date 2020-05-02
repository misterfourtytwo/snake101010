import 'package:flutter/material.dart';
import 'package:snake101010/providers/config.dart';

class Score {
  /// 12 char max
  String playerName;
  int value;
  Score({@required this.value, this.playerName});
  @override
  String toString() {
    return '$playerName: $value';
  }
  // @override
  // bool operator ==(o) => o is Score && o.score == score && o.playerName == playerName;
}

class ScoreBoard {
  List<Score> _scores;
  ScoreBoard([List<Score> scores]) {
    _scores = scores ??
        [
          Score(value: 4242, playerName: 'vasya'),
          Score(value: 99999, playerName: 'King'),
          Score(value: 14, playerName: 'Saitama'),
          Score(value: 65536, playerName: 'Genos'),
        ];
    _scores = getScores();
  }

  List<Score> getScores({Score current}) {
    var x = _scores.toList();
    if (current != null && current.value != 0) {
      current.playerName ??= 'Current';
      x.add(current);
    }
    x.sort(
      (a, b) => b.value.compareTo(a.value),
    );
    if (x.length > Config.scoreboardLength) x.removeLast();
    return x;
  }

  bool pushScore(Score s) {
    _scores = getScores(current: s);
    return _scores.contains(s);
  }
}
