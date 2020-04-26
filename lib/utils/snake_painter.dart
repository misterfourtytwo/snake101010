import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';

class SnakePainter extends CustomPainter {
  GameState state;
  Config config;
  Paint snakeBodyPaint,
      shadowsPaint,
      bountyPaint,
      highlightsPaint,
      outlinePaint;

  SnakePainter() {
    config = GetIt.I<Config>();
    state = GetIt.I<GameState>();
    snakeBodyPaint = Paint()..color = Colors.green[700];
    bountyPaint = Paint()..color = Colors.red[900];
    shadowsPaint = Paint()..color = Colors.blueGrey[900].withOpacity(0.6);
    highlightsPaint = Paint()..color = Colors.white54;
    outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
  }

  // void tick(Snake newSnake, MyPoint newBounty, int tick) {
  //   snake = newSnake;
  //   bounty = newBounty;
  // }

  drawBounty(Canvas canvas) {
    // shadows
    canvas.drawCircle(
        config.padding +
            Offset((state.bounty.location.x + .45) * config.cellSide,
                (state.bounty.location.y + .55) * config.cellSide),
        config.cellSide * .32,
        shadowsPaint);
    // body
    canvas.drawCircle(
        config.padding +
            Offset((state.bounty.location.x + .5) * config.cellSide,
                (state.bounty.location.y + .5) * config.cellSide),
        config.cellSide * .3,
        bountyPaint);
    // highlight
    canvas.drawCircle(
        config.padding +
            Offset((state.bounty.location.x + .58) * config.cellSide,
                (state.bounty.location.y + .40) * config.cellSide),
        config.cellSide * .1,
        highlightsPaint);
  }

  drawSnake(Canvas canvas) {
    // shadows
    state.snake.body.forEach((e) => canvas.drawCircle(
          config.padding +
              Offset(
                (e.x + .4) * config.cellSide,
                (e.y + .7) * config.cellSide,
              ),
          config.cellSide * .65,
          shadowsPaint,
        ));

    // outline
    state.snake.body.forEach((e) => canvas.drawCircle(
          config.padding +
              Offset(
                (e.x + .5) * config.cellSide,
                (e.y + .5) * config.cellSide,
              ),
          config.cellSide * .65,
          outlinePaint,
        ));

    //body
    state.snake.body.forEach((e) => canvas.drawCircle(
        Offset(config.leftPadding + (e.x + .5) * config.cellSide,
            config.topPadding + (e.y + .5) * config.cellSide),
        config.cellSide * .65,
        snakeBodyPaint));

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(
              config.leftPadding + (state.snake.head.x + .5) * config.cellSide,
              config.topPadding + (state.snake.head.y + .5) * config.cellSide),
          radius: config.cellSide * .55),
      pi * (state.snake.direction.index * .5 - .92),
      pi * .84,
      false,
      Paint()
        ..color = Colors.green
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = config.cellSide * .16,
    );

    //highlights
    state.snake.body.forEach((e) => canvas.drawCircle(
          Offset(
            config.leftPadding + (e.x + .7 + e.odd * .12) * config.cellSide,
            config.topPadding + (e.y + .3 - e.odd * .12) * config.cellSide,
          ),
          config.cellSide * .13,
          highlightsPaint,
        ));

    /// body shadows
    state.snake.body.forEach((e) => canvas.drawCircle(
          Offset(
            config.leftPadding + (e.x + .37) * config.cellSide,
            config.topPadding + (e.y + .7) * config.cellSide,
          ),
          config.cellSide * .24,
          shadowsPaint,
        ));

    if (state.snake.dead)
      canvas.drawCircle(
        Offset(
          config.leftPadding + (state.snake.head.x + .5) * config.cellSide,
          config.topPadding + (state.snake.head.y + .5) * config.cellSide,
        ),
        config.cellSide * .64,
        Paint()
          ..color = Colors.redAccent[700]
          ..style = PaintingStyle.stroke
          ..strokeWidth = config.cellSide * .4,
      );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawBounty(canvas);
    drawSnake(canvas);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return !state.snake.dead && state.snake.moving;
  }
}
