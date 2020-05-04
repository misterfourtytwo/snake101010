import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:snake101010/providers/config.dart';
import 'package:snake101010/providers/game_state.dart';

class GameBar extends StatelessWidget {
  const GameBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = GetIt.I<Config>();
    final barHeight = config.barHeight;
    final toppad = config.spareHeight * .025;
    final state = GetIt.I<GameState>();

    return Positioned(
      top: toppad,
      left: 0,
      right: 0,
      height: barHeight,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: config.leftPadding),
          Expanded(
            flex: 3,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              // fit: BoxFit.fitHeight,
              child: ValueListenableBuilder<int>(
                valueListenable: state.score,
                builder: (context, score, _) => Text(
                  'SCORE:\n${score}',
                  maxLines: 2,
                  // softWrap: true,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ),
          Spacer(
            flex: state.paused ? 12 : 6,
          ),
          if (!state.paused)
            Expanded(
              flex: 6,
              child: FittedBox(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 512,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.pause,
                    color: Colors.white,
                  ),
                  onPressed: () => state.setAction(ControlActions.TogglePause),
                ),
              ),
            ),
          SizedBox(width: config.leftPadding),
          // ;
          // }),
        ],
      ),
    );
  }
}
