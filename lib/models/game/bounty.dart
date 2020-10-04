import 'dart:math';

class Bounty {
  final Point<int> position;
  final bool isMega;

  Bounty(
    this.position, {
    this.isMega = false,
  });
}
