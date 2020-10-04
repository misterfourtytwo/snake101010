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
      ..color = Colors.blueGrey[900]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    // config.cellSide * .2;
  }

  drawBounty(Canvas canvas) {
    // shadows
    canvas.drawCircle(
      Offset(state.bounty.position.x + .45, state.bounty.position.y + .55) *
              config.cellSide +
          config.padding,
      config.cellSide *
          (.32 +
              (state.bounty.isMega
                  ? max(0, (1.0 - state.bounty.tick / config.fieldArea)) * .5
                  : 0)),
      shadowsPaint,
    );
    // outline
    canvas.drawCircle(
      Offset(state.bounty.position.x + .5, state.bounty.position.y + .5) *
              config.cellSide +
          config.padding,
      config.cellSide *
          (.32 +
              (state.bounty.isMega
                  ? max(0, (1.0 - state.bounty.tick / config.fieldArea)) * .4
                  : 0)),
      outlinePaint,
    );
    // body
    canvas.drawCircle(
      Offset(state.bounty.position.x + .5, state.bounty.position.y + .5) *
              config.cellSide +
          config.padding,
      config.cellSide *
          (.3 +
              (state.bounty.isMega
                  ? max(0, (1.0 - state.bounty.tick / config.fieldArea)) * .4
                  : 0)),
      bountyPaint,
    );
    // highlight
    canvas.drawCircle(
      Offset(state.bounty.position.x + .58, state.bounty.position.y + .40) *
              config.cellSide +
          config.padding,
      config.cellSide *
          (.1 +
              (state.bounty.isMega
                  ? max(0, (1.0 - state.bounty.tick / config.fieldArea)) * .2
                  : 0)),
      highlightsPaint,
    );
  }

  drawSnake(Canvas canvas) {
    // shadows
    state.snake.body.forEach((e) => canvas.drawCircle(
          Offset(e.x + .4, e.y + .7) * config.cellSide + config.padding,
          config.cellSide * .65,
          shadowsPaint,
        ));

    // outline
    state.snake.body.forEach((e) => canvas.drawCircle(
          Offset(e.x + .5, e.y + .5) * config.cellSide + config.padding,
          config.cellSide * .65,
          outlinePaint,
        ));

    //body
    state.snake.body.forEach((e) => canvas.drawCircle(
          Offset(e.x + .5, e.y + .5) * config.cellSide + config.padding,
          config.cellSide * .65,
          snakeBodyPaint,
        ));

    // head
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(state.snake.head.x + .5, state.snake.head.y + .5) *
                  config.cellSide +
              config.padding,
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
          Offset(e.x + .7 - e.odd * .1, e.y + .3 - e.odd * .14) *
                  config.cellSide +
              config.padding,
          config.cellSide * (-e.odd * .04 + .18),
          highlightsPaint,
        ));

    /// body shadows
    state.snake.body.forEach((e) => canvas.drawCircle(
          Offset(
                    e.x + .37,
                    e.y + .7,
                  ) *
                  config.cellSide +
              config.padding,
          config.cellSide * .24,
          shadowsPaint,
        ));

    if (state.snake.isDead)
      canvas.drawCircle(
        Offset(
                  state.snake.head.x + .5,
                  state.snake.head.y + .5,
                ) *
                config.cellSide +
            config.padding,
        config.cellSide * .64,
        Paint()
          ..color = Colors.redAccent[700]
          ..style = PaintingStyle.stroke
          ..strokeWidth = config.cellSide * .4,
      );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawSnake(canvas);
    drawBounty(canvas);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return !(state.paused && state.snake.isDead);
  }
}
