import 'package:snake101010/models/game/actions.dart';
import 'package:snake101010/models/game/bounty.dart';
import 'package:snake101010/models/game/field.dart';
import 'package:snake101010/models/game/snake.dart';
import 'package:snake101010/providers/config.dart';

enum GameStateMode {
  /// snake moves each turn
  playing,

  /// snake stopped, show pause menu
  paused,

  /// player lost but hadn't restarted
  end,
}

class GameState {
  Random _rand;

  // data
  Field field;
  Snake snake;
  Bounty bounty;
  ValueNotifier<int> score;
  String playerName = '';

  // flow contol
  bool awaitingStart;
  bool paused;
  GameAction lastAction;
  bool saved;

  // int get score => score.value;
  setScore(int newValue) => score.value = newValue;

  GameState() {
    _rand = Random(DateTime.now().millisecondsSinceEpoch);
    score = ValueNotifier<int>(0);
    reset();
  }

  reset() {
    snake = Snake();
    bounty = Bounty(emptySpot());
    score.value = 0;

    awaitingStart = true;
    paused = true;
    lastAction = null;
    _tickLock = false;
    _tick = 0;
    _lastTick = -1;
    saved = false;

    _lastPauseToggle = DateTime.now();
  }

  dispose() {
    score.dispose();
  }

  MyPoint emptySpot() {
    MyPoint newLocation;
    do {
      int bp = _rand.nextInt(config.fieldArea - snake.length);
      newLocation = MyPoint(bp % config.fieldWidth, bp ~/ config.fieldWidth);
    } while (snake.contains(newLocation));
    return newLocation;
  }

  // create next bounty object positioned in empty cell
  Bounty nextBounty() => Bounty(
        emptySpot(),
        number: bounty.number + 1,
        isMega: (bounty.number % Config.bountyFrequency ==
                Config.bountyFrequency - 1)
            ? true
            : false,
      );

  start() {
    awaitingStart = false;
    paused = false;
  }

  void move() {
    if (paused) return;
    bounty.tick++;

    final nextHead = snake.nextHead();
    if (nextHead != bounty.position) {
      snake.dropTail();
      if (!snake.addHead(nextHead)) paused = true;
    } else {
      score.value += (bounty.isMega ? config.fieldArea ~/ bounty.tick + 1 : 1) *
          config.speed;
      snake.addHead(nextHead);
      bounty = nextBounty();
    }
  }
}
