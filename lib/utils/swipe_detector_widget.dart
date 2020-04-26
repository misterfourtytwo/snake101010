import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:snake101010/models/snake.dart';

import 'package:snake101010/providers/game_state.dart';

class SwipeDetectorWidget extends StatelessWidget {
  const SwipeDetectorWidget({this.child, Key key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final GameState state = GetIt.I<GameState>();
    return SimpleGestureDetector(
      swipeConfig: SimpleSwipeConfig(
        horizontalThreshold: 21,
        verticalThreshold: 21,
        swipeDetectionBehavior: SwipeDetectionBehavior.continuous,
      ),
      onHorizontalSwipe: (SwipeDirection dir) {
        if (!state.snake.moving ||
            state.snake.direction == Direction.left ||
            state.snake.direction == Direction.right) return;
        state.snake.direction =
            dir == SwipeDirection.left ? Direction.left : Direction.right;
      },
      onVerticalSwipe: (SwipeDirection dir) {
        if (!state.snake.moving ||
            state.snake.direction == Direction.up ||
            state.snake.direction == Direction.down) return;
        state.snake.direction =
            dir == SwipeDirection.up ? Direction.up : Direction.down;
      },
      child: child,
    );
  }
}
