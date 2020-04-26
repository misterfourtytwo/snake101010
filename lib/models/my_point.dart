// import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';

class MyPoint {
  MyPoint(this.x, this.y);
  int x, y;

  int _isOdd;
  int get odd => _isOdd ?? (_isOdd = (x + y) % 2);
  // Offset get point => Offset(x.toDouble(), y.toDouble());
  @override
  bool operator ==(o) => o is MyPoint && o.x == x && o.y == y;

  @override
  int get hashCode => x + y * GetIt.I<Config>().fieldWidth;

  @override
  String toString() {
    return "MyPoint<x: $x, y: $y>";
  }
}
