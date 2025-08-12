import 'dart:async';

import 'package:clean_arch_flutter_bloc/core/dependency_registrar/dependencies.dart';
import 'package:clean_arch_flutter_bloc/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      // binding is needed before calling runApp
      WidgetsFlutterBinding.ensureInitialized();

      await slInit();

      runApp(
        AppRoot(),
      );
    },
    (error, stack) => {},
  );
}
