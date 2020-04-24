import 'package:snake101010/config.dart';

class MyPoint {
  MyPoint(this.x, this.y)
      : assert(x < Config.fieldWidth),
        assert(y < Config.fieldHeight);
  int x, y;

  @override
  bool operator ==(o) => o is MyPoint && o.x == x && o.y == y;

  @override
  int get hashCode => x + y * Config.fieldWidth;

  @override
  String toString() {
    return "MyPoint<x: $x, y: $y>";
  }
}
