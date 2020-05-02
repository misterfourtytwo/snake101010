import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/game_state.dart';

class GoOverlay extends StatelessWidget {
  const GoOverlay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recognizeYes = TapGestureRecognizer();
    recognizeYes.onTapUp =
        (_) => GetIt.I<GameState>().setAction(ControlActions.Restart);
    final recognizeNo = TapGestureRecognizer();
    recognizeNo.onTapUp = (_) {
      GetIt.I<GameState>().setAction(ControlActions.EndGame);
      Navigator.of(context).pop();
    };

    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      child: FittedBox(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(text: 'You died\n'),
            TextSpan(text: 'Restart?\n'),
            TextSpan(text: ' Y ', recognizer: recognizeYes),
            TextSpan(text: '/'),
            TextSpan(text: ' N ', recognizer: recognizeNo),
          ], style: Theme.of(context).textTheme.headline1),
          maxLines: 3,
          softWrap: true,
        ),
      ),
    );
  }
}
