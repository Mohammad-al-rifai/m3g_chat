// ignore_for_file: avoid_print

import 'package:m3g_chat/app/components/widgets/toast_notification.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../config/urls.dart';

class SocketIO {
  const SocketIO._internal();

  static const SocketIO _instance =
      SocketIO._internal(); // Singleton or Single Instance.
  factory SocketIO() => _instance; //factory

  static IO.Socket? socket;

  static initSocket() {
    socket = IO.io(Urls.baseUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket?.connect();
    socket?.onConnect((_) {
      print('Connection established');
    });
    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
  }
}
