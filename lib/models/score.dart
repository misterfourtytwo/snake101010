class Score {
  String playerName;
  int value;
  Score(this.value, {this.playerName});
  @override
  String toString() {
    return '$playerName: $value';
  }

  @override
  bool operator ==(o) =>
      o is Score && o.value == value && o.playerName == playerName;

  @override
  int hashCode() => value + playerName.hashCode * 1000000;
}
