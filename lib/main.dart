import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'config/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}
