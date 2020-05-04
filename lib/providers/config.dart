import 'dart:math';

import 'package:flutter/material.dart';

class Config {
  // ticks<>frames per second
  static const fps = 30;

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
    this.speed = 30,
    this.fieldHeight = 16,
    this.fieldWidth = 21,
    this.drawControls = true,
  });

  // game view settings
  bool drawControls;
  Size _size;
  bool shouldRepaint = false;

  double _barHeight;
  double _controlsHeight;
  double _cellSide;
  double _hPad;
  double _vPad;
  Offset _padding;

  Size get size => _size;
  set size(Size newValue) {
    shouldRepaint = true;
    _barHeight = _cellSide = _hPad = _vPad = _padding = _controlsHeight = null;
    _size = newValue;
  }

  // size.height = barHeight + _controlsHeight + gameHeight
  double get barHeight => _barHeight ?? (_barHeight = size.height * 0.1);
  double get controlsHeight =>
      _controlsHeight ?? (_controlsHeight = size.height * 0.1);
  double get spareHeight => size.height - barHeight - controlsHeight;
  double get cellSide =>
      _cellSide ??
      (_cellSide = min(size.width * .9 / this.fieldWidth,
          spareHeight * .9 / this.fieldHeight));
  double get gameHeight => cellSide * this.fieldHeight;
  double get leftPadding =>
      _hPad ?? (_hPad = (size.width - cellSide * this.fieldWidth) * .5);
  double get topPadding => _vPad ?? (_vPad = spareHeight * .05 + barHeight);
  Offset get padding => _padding ?? Offset(leftPadding, topPadding);
}
