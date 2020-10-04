import 'package:snake101010/models/score.dart';
import 'package:snake101010/providers/config.dart';

class ScoreBoard {
  List<Score> _scores;
  ScoreBoard([List<Score> scores]) {
    _scores = scores ??
        [
          Score(99999, playerName: 'King'),
          Score(65536, playerName: 'Genos'),
          Score(4242, playerName: 'vasya'),
          Score(14, playerName: 'Saitama'),
        ];
  }

  List<Score> getScores([Score current]) {
    var x = _scores.toList();

    if (current != null && current.value != 0) {
      current.playerName ??= 'Current';
      x.add(current);
      x.sort((a, b) => b.value.compareTo(a.value));
      if (x.length > Config.scoreboardLength) x.removeLast();
    }

    return x;
  }

  bool add(Score s) {
    _scores = getScores(s);
    return _scores.contains(s);
  }
}
