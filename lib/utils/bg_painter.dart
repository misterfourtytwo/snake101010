import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/config.dart';

class BgPainter extends CustomPainter {
  double hPad, vPad, cellSize;
  Paint bgPaint;
  Config config;

  BgPainter() {
    config = GetIt.I<Config>();

    bgPaint = Paint();
    bgPaint.color = config.bgDotColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO ???? maybe drawColor is better
    canvas.drawPaint(Paint()..color = config.bgColor);
    for (var i = 0; i < config.fieldWidth; i++)
      for (var j = 0; j < config.fieldHeight; j++)
        canvas.drawCircle(
          config.padding +
              Offset(
                (i + .5) * config.cellSide,
                (j + .5) * config.cellSide,
              ),
          config.cellSide * .15,
          bgPaint,
        );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (config.shouldRepaint) {
      // TODO ????? check whether needed
      bgPaint.color = config.bgDotColor;
      config.shouldRepaint = false;
      return true;
    }
    return false;
  }
}
