import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';

class GameControls extends StatelessWidget {
  const GameControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = GetIt.I<Config>();
    final botpad =
        config.gameHeight + config.topPadding + config.spareHeight * .025;
    final state = GetIt.I<GameState>();
    return Positioned(
      top: botpad,
      left: config.leftPadding,
      right: config.leftPadding,
      bottom: config.spareHeight * .025,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: FittedBox(
              alignment: Alignment.bottomRight,
              fit: BoxFit.fill,
              child: RaisedButton(
                // elevation: 64,
                // materialTapTargetSize: MaterialTapTargetSize.padded,
                padding: EdgeInsets.zero,
                color: Colors.white30,
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 512,
                ),
                onPressed: () {
                  state.setAction(ControlActions.MoveLeft);
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            // flex: 9,
            child: Container(
              // color: Colors.green,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.bottomRight,
                      fit: BoxFit.fill,
                      child: RaisedButton(
                        // elevation: 64,
                        // materialTapTargetSize: MaterialTapTargetSize.padded,
                        padding: EdgeInsets.zero,
                        color: Colors.white30,
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                          size: 512,
                        ),
                        onPressed: () {
                          state.setAction(ControlActions.MoveUp);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.bottomRight,
                      fit: BoxFit.fill,
                      child: RaisedButton(
                        // elevation: 64,
                        // materialTapTargetSize: MaterialTapTargetSize.padded,
                        padding: EdgeInsets.zero,
                        color: Colors.white30,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 512,
                        ),
                        onPressed: () {
                          state.setAction(ControlActions.MoveDown);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              alignment: Alignment.bottomRight,
              fit: BoxFit.fill,
              child: RaisedButton(
                // elevation: 64,
                // materialTapTargetSize: MaterialTapTargetSize.padded,
                padding: EdgeInsets.zero,
                color: Colors.white30,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 512,
                ),
                onPressed: () {
                  state.setAction(ControlActions.MoveRight);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
