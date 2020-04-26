import 'dart:math';

import 'package:flutter/material.dart';

class Config {
  // moves per second
  int speed;

  int fieldWidth;
  int fieldHeight;
  int get fieldArea => fieldWidth * fieldHeight;

  // game colors
  Color bgDotColor = Colors.blueGrey[700];
  Color bgColor = Colors.grey[800];

  // game view settings
  bool drawControls;
  Size _size;
  bool shouldRepaint = false;

  double _barHeight;
  double _cellSide;
  double _hPad;
  double _vPad;
  Offset _padding;

  Size get size {
    return _size;
  }

  set size(Size newValue) {
    shouldRepaint = true;
    _barHeight = _cellSide = _hPad = _vPad = _padding = null;
    _size = newValue;
  }

  double get barHeight => _barHeight ?? (_barHeight = size.height * 0.08);
  double get cellSide =>
      _cellSide ??
      (_cellSide = min(size.width * .92 / this.fieldWidth,
          (size.height - _barHeight) * .92 / this.fieldHeight));
  double get leftPadding =>
      _hPad ?? (_hPad = (size.width - cellSide * this.fieldWidth) * .5);
  double get topPadding =>
      _vPad ??
      (_vPad = (size.height - cellSide * this.fieldHeight + _barHeight) * .5);
  Offset get padding => _padding ?? Offset(leftPadding, topPadding);

  Config({
    this.speed = 10,
    this.fieldHeight = 10,
    this.fieldWidth = 10,
    this.drawControls = false,
  });
}

// cellSize = min(size.width * .92 / Config.fieldWidth,
//     (size.height - 42) * .92 / Config.fieldHeight);
// hPad = (size.width - cellSize * Config.fieldWidth) * .5;
// vPad = (size.height - 42 - cellSize * Config.fieldHeight) * .5 + 42;
