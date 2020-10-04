import 'dart:math';

import 'package:snake101010/models/game/tile.dart';

enum FieldSize { small, medium, large }

class Field {
  final FieldSize size;
  final int width;
  final int height;
  List<Tile> field;

  Field({this.size = FieldSize.medium, this.field})
      : width =
            (size == FieldSize.small ? 8 : size == FieldSize.medium ? 16 : 24),
        height =
            (size == FieldSize.small ? 8 : size == FieldSize.medium ? 16 : 24),
        assert(field == null || field.length == height * width) {
    field ??= List<Tile>(width * height);
  }

  operator [](Point<int> p) => field[p.x + p.y * width];

  insert(Tile t) {
    field[t.position.x + t.position.y * width] = t;
  }

  insertAll(List<Tile> tiles) {
    tiles.forEach(insert);
  }
}
