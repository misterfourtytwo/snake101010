import 'package:flutter/material.dart';

import 'package:snake101010/models/game/field.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int speed;
  FieldSize size;
  bool nightMode;
  bool showControls;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.black87,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          'Settings',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Speed'),
                            Expanded(
                              child: Slider(
                                min: 2,
                                max: 30,
                                divisions: 15,
                                label: '$speed',
                                value: speed.toDouble(),
                                onChanged: (v) => setState(() {
                                  speed = v.round();
                                }),
                              ),
                            ),
                          ],
                        ),
                        Text('night theme'),
                        Text('show controls'),
                        Text('field size') // small, medium, large
                      ],
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
            )),
      ),
    );
  }
}
