import 'dart:math';

import 'package:hive/hive.dart';

// part 'tile.g.dart';

@HiveType(typeId: 0)
enum TileType {
  @HiveField(0)
  empty,
  @HiveField(1)
  snake,
  @HiveField(2)
  bounty,
  @HiveField(3)
  obstacle,
  @HiveField(4)
  teleport,
}

@HiveType(typeId: 1)
class Tile {
  @HiveField(0)
  TileType type;
  @HiveField(1)
  Point<int> position;

  Tile(this.position, {this.type = TileType.empty});
  Tile.snake(this.position) : type = TileType.snake;
  Tile.bounty(this.position) : type = TileType.bounty;
  Tile.obstacle(this.position) : type = TileType.obstacle;
  Tile.teleport(this.position) : type = TileType.teleport;
}
