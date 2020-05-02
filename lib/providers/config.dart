import 'dart:math';

import 'package:flutter/material.dart';

class Config {
  // ticks<>frames per second
  static const fps = 60;

  // bounty frequency e.g. every 8th bounty is mega
  static const bountyFrequency = 8;
  static const scoreboardLength = 10;

  // game colors
  final Color bgDotColor = Colors.blueGrey[700];
  final Color bgColor = Colors.grey[800];

  int fieldWidth;
  int fieldHeight;
  int get fieldArea => fieldWidth * fieldHeight;

  // moves per second
  final int speed;

  Config({
    this.speed = 12,
    this.fieldHeight = 16,
    this.fieldWidth = 21,
    this.drawControls = false,
  });

  // game view settings
  bool drawControls;
  Size _size;
  bool shouldRepaint = false;

  double _barHeight;
  double _cellSide;
  double _hPad;
  double _vPad;
  Offset _padding;

  Size get size => _size;
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
}
