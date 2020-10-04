enum GameAction {
  MoveUp,
  MoveRight,
  MoveDown,
  MoveLeft,
  TogglePause,

  /// restart game
  Restart,

  /// leave screen with game feld
  LeaveField,

  /// leave screen with game field and reset game
  EndGame,
}
