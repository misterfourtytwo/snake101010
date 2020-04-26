import 'package:snake101010/models/my_point.dart';

class Bounty {
  int number;
  MyPoint location;

  bool isMega;
  int tick;

  Bounty(
    this.location, {
    this.number = 0,
    this.isMega = false,
    this.tick = 1,
  });
}
