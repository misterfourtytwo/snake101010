0.[Main]
* hook up hive
* register services into getIt
--- launch Main
    * [MaterialApp]
    --- shows [MenuView]
    * simple view with 3 buttons
    * could navigate to
    --- [GameView]
    --- [ScoreBoard]
    --- [Settings]

1.[GameView]
* [LayoutBuilder] > [ControlsWidget] > [Stack]
* redraws ui in response to resize
* listens to input and updates game state accordingly
* [Stack] contains ui
    --- [GameField]
    --- [GameBar]
    --- (TBD) [UiControls]
    --- (GameOver) [GoOverlay] or (TBD) [PauseOverlay]

    0.[GameField]
    * paints background field
    * paints snake and apple on foreground
    * starts timer which sends ticks to state
    1.[GameBar]
    * current score
    * (TBD?) current time
    * pause button
    2.[UiControls]
    * draws control buttons
    3.[GoOverlay]
    * Question about game restart
    --- Y ->
    * push result to [ScoreBoard]
    * reset gameState
    * play again
    --- N -> return to [MenuView]
    4.[PauseOverlay]
    (TBD)
    * resume
    * restart
    * open settings
    * return to [MenuView]

2.[GameState]
* main logic behind the game
* snake with its position, direction, moving
* (apple) bounty creation, position
* current game score
* (TBD) load last game on open

3.Scoreboard
in progress

4.Settings
TBD