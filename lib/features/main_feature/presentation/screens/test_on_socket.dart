// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// import '../../../../config/urls.dart';
//
// class TestOn extends StatefulWidget {
//   const TestOn({Key? key}) : super(key: key);
//
//   @override
//   State<TestOn> createState() => _TestOnState();
// }
//
// class _TestOnState extends State<TestOn> {
//   /// fOR SOCKET
//   // ====================================================
//   IO.Socket? socket;
//
//   initSocket() {
//     socket = IO.io(Urls.baseUrl, <String, dynamic>{
//       'autoConnect': false,
//       'transports': ['websocket'],
//     });
//     socket?.connect();
//     socket?.onConnect((_) {
//       print('Connection established');
//     });
//     socket?.onDisconnect((_) => print('Connection Disconnection'));
//     socket?.onConnectError((err) => print(err));
//     socket?.onError((err) => print(err));
//     socket?.on('message', (data) {
//       print(data);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     initSocket();
//     socket?.emit('new user', {
//       "username": "test",
//       "phone": 123456789,
//       "id": '63ad94d30775aa3238eae431',
//     });
//   }
//
//   @override
//   void dispose() {
//     socket?.disconnect();
//     socket?.dispose();
//     super.dispose();
//   }
//
//   final Stream<int> _bids = (() {
//     late final StreamController<int> controller;
//     controller = StreamController<int>(
//       onListen: () async {
//         await Future<void>.delayed(const Duration(seconds: 2));
//         controller.add(1000);
//         await Future<void>.delayed(const Duration(seconds: 5));
//         await controller.close();
//       },
//     );
//     return controller.stream;
//   })();
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle(
//       style: Theme.of(context).textTheme.displayMedium!,
//       textAlign: TextAlign.center,
//       child: Container(
//         alignment: FractionalOffset.center,
//         color: Colors.white,
//         child: StreamBuilder<int>(
//           stream: _bids,
//           builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//             List<Widget> children;
//             if (snapshot.hasError) {
//               children = <Widget>[
//                 const Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                   size: 60,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text('Error: ${snapshot.error}'),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Text('Stack trace: ${snapshot.stackTrace}'),
//                 ),
//               ];
//             } else {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.none:
//                   children = const <Widget>[
//                     Icon(
//                       Icons.info,
//                       color: Colors.blue,
//                       size: 60,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 16),
//                       child: Text('Select a lot'),
//                     ),
//                   ];
//                   break;
//                 case ConnectionState.waiting:
//                   children = const <Widget>[
//                     SizedBox(
//                       width: 60,
//                       height: 60,
//                       child: CircularProgressIndicator(),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 16),
//                       child: Text('Awaiting bids...'),
//                     ),
//                   ];
//                   break;
//                 case ConnectionState.active:
//                   children = <Widget>[
//                     const Icon(
//                       Icons.check_circle_outline,
//                       color: Colors.green,
//                       size: 60,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16),
//                       child: Text('\$${snapshot.data}'),
//                     ),
//                   ];
//                   break;
//                 case ConnectionState.done:
//                   children = <Widget>[
//                     const Icon(
//                       Icons.info,
//                       color: Colors.blue,
//                       size: 60,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16),
//                       child: Text('\$${snapshot.data} (closed)'),
//                     ),
//                   ];
//                   break;
//               }
//             }
//
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: children,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
