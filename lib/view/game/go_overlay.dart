import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:snake101010/providers/game_state.dart';
import 'package:uic/inline_text_field.dart';

class GoOverlay extends StatefulWidget {
  const GoOverlay({Key key}) : super(key: key);

  @override
  _GoOverlayState createState() => _GoOverlayState();
}

class _GoOverlayState extends State<GoOverlay> {
  bool saved = false;
  final state = GetIt.I<GameState>();

  @override
  Widget build(BuildContext context) {
    final recognizeYes = TapGestureRecognizer();
    recognizeYes.onTapUp =
        (_) => GetIt.I<GameState>().setAction(ControlActions.Restart);
    final recognizeNo = TapGestureRecognizer();
    recognizeNo.onTapUp = (_) {
      state.setAction(ControlActions.EndGame);
      Navigator.of(context).pop();
      // .pushNamedAndRemoveUntil('/menu', (route) => route.isFirst);
    };

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
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
            ),
            Expanded(
              child: FittedBox(
                child: Text(
                  'Score: ${GetIt.I<GameState>().score.value}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Name: ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  saved
                      ? Text(
                          state.playerName,
                          style: Theme.of(context).textTheme.headline1,
                        )
                      : Container(
                          child: InlineTextField(
                            // text: state.playerName,
                            child: Text(
                              '${state.playerName}',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            onEditingComplete: (newName) {
                              state.playerName = newName;
                              setState(() => state.saved = true);
                            },
                            styleEditing: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
