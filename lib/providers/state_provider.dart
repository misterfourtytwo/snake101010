import 'package:snake101010/exports.dart';

import 'package:snake101010/models/game/actions.dart';

enum StateStatus {
  Empty,
  AwaitingStart,
  Running,
  Paused,
  GameOver,
}

enum GameLevel {
  Inifinity,
  Level1,
  Level2,
  Level3,
  Level4,
  Level6,
  Level7,
  Level8,
  Level9,
}

class GameStateProvider extends ChangeNotifier {
  Point<int> direction;
  GameAction lastAction;
  ValueNotifier<StateStatus> status;
  int currentScore;
  DateTime _lastPauseToggle;

  GameStateProvider() {
    status = ValueNotifier<StateStatus>(StateStatus.Empty);
  }

  void loadGame() {}
  void newGame([GameLevel level]) {}
  void start() {}
  void pause() {}

  void setAction(GameAction action) {
    // print('Set action $action');
  }
  //   switch (action) {
  //     case (ControlAction.LeaveField):
  //       //TODO add some handlers???
  //       lastAction = action;
  //       break;
  //     case (ControlAction.EndGame):
  //     case (ControlAction.Restart):
  //       GetIt.I<ScoreBoard>()
  //           .pushScore(Score(value: score.value, playerName: playerName));
  //       reset();
  //       break;

  //     case (ControlAction.TogglePause):
  //       if (DateTime.now().difference(_lastPauseToggle).inMilliseconds > 500) {
  //         // print('togglePause');
  //         lastAction = ControlAction.TogglePause;
  //         _lastPauseToggle = DateTime.now();
  //       }
  //       break;
  //     default:
  //       // !paused && !snake.dead && direction isnt opposite of current
  //       // awaitingStart && !snake.dead && direction isnt opposite of current
  //       if ((awaitingStart || !paused) &&
  //           !(snake.isDead ||
  //               Direction.values[(action.index + 2) % 4] == snake.direction))
  //         lastAction = action;
  //   }
  // }

  // bool _tickLock;
  // int _tick;
  // // last tick when we moved snake
  // int _lastTick;

  // /// update state on tick
  // void nextTick() {
  //   // check whether last tick aren't finished yet
  //   if (_tickLock) return;
  //   _tickLock = true;
  //   _tick++;
  //   // check whether we need to move snake
  //   // 25 ticks per second, config.speed updates per one
  //   // dTicks * .04 sec < 1.0 sec / config.speed
  //   if ((_tick - _lastTick) * config.speed < Config.fps) {
  //     // print('skip tick');
  //     _tickLock = false;
  //     return;
  //   }
  //   // print('tick');
  //   _lastTick = _tick;

  //   if (paused) {
  //     if (lastAction == null) {
  //       _tickLock = false;
  //       return;
  //     } else if (lastAction == ControlAction.TogglePause) {
  //       // paused = false;
  //       start();
  //       lastAction = null;
  //       move();
  //     } else if (lastAction == ControlAction.LeaveField) {
  //       awaitingStart = true;
  //       paused = true;
  //     }
  //     // last action aint one of those and we gotta tick so it should be arrow
  //     else if (awaitingStart) {
  //       start();
  //       snake.direction = Direction.values[lastAction.index];
  //       move();
  //     }
  //     lastAction = null;
  //     _tickLock = false;
  //     return;
  //   } else {
  //     // print('not paused');
  //     // print('last action: $lastAction');
  //     if (lastAction != null) {
  //       if (lastAction.index < 4)
  //         snake.direction = Direction.values[lastAction.index];
  //       else if (lastAction == ControlAction.TogglePause)
  //         paused = true;
  //       else if (lastAction == ControlAction.LeaveField) {
  //         awaitingStart = true;
  //         paused = true;
  //       }

  //       lastAction = null;
  //     }
  //     move();
  //   }
  //   _tickLock = false;
  // }
}
