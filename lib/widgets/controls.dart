import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:snake101010/models/snake.dart';

import 'package:snake101010/providers/game_state.dart';

class ControlsWidget extends StatefulWidget {
  const ControlsWidget({this.child, Key key}) : super(key: key);
  final Widget child;

  @override
  _ControlsWidgetState createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  FocusNode _focusNode;
  GameState state;

  @override
  void initState() {
    super.initState();
    state = GetIt.I<GameState>();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    // print(event.physicalKey);
    var newDirection;

    if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
      newDirection = Direction.up;
    } else if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
      newDirection = Direction.down;
    } else if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
      newDirection = Direction.left;
    } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
      newDirection = Direction.right;
    }
    if (newDirection != null)
      _redirect(newDirection);
    else {
      // pause toggle
      if (event.physicalKey == PhysicalKeyboardKey.space) {
        state.setAction(ControlActions.TogglePause);
      }
      // leave game screen
      else if (event.physicalKey == PhysicalKeyboardKey.escape) {
        state.setAction(ControlActions.LeaveField);
        Navigator.of(context).pop();
        // .pushNamedAndRemoveUntil('/menu', (route) => route.isFirst);
      }
      // check answer to game over message
      else if (state.snake.dead) {
        if (event.physicalKey == PhysicalKeyboardKey.keyY ||
            event.physicalKey == PhysicalKeyboardKey.enter) {
          state.setAction(ControlActions.Restart);
        } else if (event.physicalKey == PhysicalKeyboardKey.keyN) {
          state.setAction(ControlActions.EndGame);
          Navigator.of(context).pop();
          // .pushNamedAndRemoveUntil('/menu', (route) => route.isFirst);
        }
      }
    }
  }

  void _redirect(Direction direction) {
    state.setAction(ControlActions.values[direction.index]);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKey: _handleKeyEvent,
      child: SimpleGestureDetector(
        swipeConfig: SimpleSwipeConfig(
          horizontalThreshold: 21,
          verticalThreshold: 21,
          swipeDetectionBehavior: SwipeDetectionBehavior.continuous,
        ),
        onHorizontalSwipe: (SwipeDirection dir) {
          _redirect(
              dir == SwipeDirection.left ? Direction.left : Direction.right);
        },
        onVerticalSwipe: (SwipeDirection dir) {
          _redirect(dir == SwipeDirection.up ? Direction.up : Direction.down);
        },
        child: widget.child,
      ),
    );
  }
}
