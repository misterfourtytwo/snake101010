import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:snake101010/exports.dart';
import 'package:snake101010/models/game/actions.dart';
import 'package:snake101010/providers/state_provider.dart';

class ControlsWidget extends StatefulWidget {
  const ControlsWidget({this.child, Key key}) : super(key: key);
  final Widget child;

  @override
  _ControlsWidgetState createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  FocusNode _focusNode;
  GameStateProvider stateProvider;

  @override
  void initState() {
    super.initState();
    stateProvider = sl<GameStateProvider>();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    GameAction newDirection;

    if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
      newDirection = GameAction.MoveUp;
    } else if (event.physicalKey == PhysicalKeyboardKey.arrowRight) {
      newDirection = GameAction.MoveRight;
    } else if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
      newDirection = GameAction.MoveDown;
    } else if (event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
      newDirection = GameAction.MoveLeft;
    }
    if (newDirection != null)
      _redirect(newDirection);
    else {
      // pause toggle
      if (event.physicalKey == PhysicalKeyboardKey.space) {
        stateProvider.setAction(GameAction.TogglePause);
      }
      // leave game screen
      else if (event.physicalKey == PhysicalKeyboardKey.escape) {
        stateProvider.setAction(GameAction.LeaveField);
        Navigator.of(context).pop();
      }
      // check answer to game over message
      else if (stateProvider.gameOver) {
        if (event.physicalKey == PhysicalKeyboardKey.keyY ||
            event.physicalKey == PhysicalKeyboardKey.enter) {
          stateProvider.setAction(GameAction.Restart);
        } else if (event.physicalKey == PhysicalKeyboardKey.keyN) {
          stateProvider.setAction(GameAction.EndGame);
          Navigator.of(context).pop();
        }
      }
    }
  }

  void _redirect(GameAction action) {
    stateProvider.setAction(action);
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
          _redirect(dir == SwipeDirection.left
              ? GameAction.MoveLeft
              : GameAction.MoveRight);
        },
        onVerticalSwipe: (SwipeDirection dir) {
          _redirect(dir == SwipeDirection.up
              ? GameAction.MoveUp
              : GameAction.MoveDown);
        },
        child: widget.child,
      ),
    );
  }
}
