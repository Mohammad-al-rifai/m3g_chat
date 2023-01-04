import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:m3g_chat/app/components/resources/constants_manager.dart';

import 'package:m3g_chat/app/socket_io/socket_io.dart';

import 'app/encryption/SignAndVerify.dart';
import 'app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SocketIO.initSocket();
  Rsa.init();
  AppConstants.level = 4;
  runApp(MyApp());
}
