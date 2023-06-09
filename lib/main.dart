import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_win32_examples/presentation/app.dart';
import 'package:flutter_win32_examples/utils/utils.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const App());
    },
    (e, stackTrace) => logg(e, stackTrace),
  )!
      .catchError(
    (e) {
      logg('FAILED TO INIT APP', e);
      exit(-1);
    },
  );
}
