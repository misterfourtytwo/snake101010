import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black87,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FittedBox(
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [],
                ),
              ),
            ),
            FlatButton(
                child: FittedBox(
                  child: Text(
                    '   Back   ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ));
  }
}
