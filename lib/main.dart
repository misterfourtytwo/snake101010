import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:snake101010/app.dart';
import 'package:snake101010/exports.dart';

void main() async {
  await _initHive();
  runApp(App());
}

const _desktopDbPath = './db';

/// open database and boxes in it
_initHive() async {
  if (isNotDesktop) {
    await Hive.initFlutter();
  } else {
    Hive.init(_desktopDbPath);
  }

  // Hive.registerAdapter()
  // Hive.registerAdapter(SnakeAdapter());

  await Hive.openBox('config');
  await Hive.openBox('state')
      // ..clear()
      ;
  await Hive.openBox('scoreboard')
      // ..clear()
      ;
}
