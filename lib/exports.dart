export 'dart:math';

export 'package:flutter/foundation.dart';
export 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:universal_platform/universal_platform.dart';

export 'package:snake101010/providers/state_provider.dart';

final sl = GetIt.I;
final bool isNotDesktop = (UniversalPlatform.isWeb ||
    UniversalPlatform.isAndroid ||
    UniversalPlatform.isIOS);
