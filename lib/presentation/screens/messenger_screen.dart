// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:m3g_chat/app/components/resources/color_manager.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:m3g_chat/app/components/resources/styles_manager.dart';
import 'package:m3g_chat/app/components/widgets/defalut_form_field.dart';
import 'package:m3g_chat/app/encryption/pgp_algorithm.dart';
import 'package:m3g_chat/app/logic/func.dart';

import '../../../../app/socket_io/socket_io.dart';
import '../../domain/models/all_users_model.dart';
import 'chat_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  TextEditingController searchController = TextEditingController();
  AllUsersModel allUsersModel = AllUsersModel();

  @override
  void initState() {
    super.initState();
    SocketIO.socket?.emit('new user', {
      'username': AppConstants.username,
      'phone': AppConstants.phone,
      'id': AppConstants.uId,
    });
    SocketIO.socket?.on('user-in', (data) {
      print('user-in Success');
      AppConstants.publicKey = data['PublicKey'];
      setState(() {});
    });
    SocketIO.socket?.emit('getUsers', {}); // send  Request
    SocketIO.socket?.on('All-Users', (data) {
      print('Get Users Success');
      allUsersModel = AllUsersModel.fromJson(data);
      setState(() {});
    });

    if (AppConstants.level == 3 || AppConstants.level == 4) {
      PGPAlGO.encryptSession().then((value) {
        SocketIO.socket?.emit(
          'newSessionKey',
          {'SessionKey': value},
        );
      });

      SocketIO.socket?.on('Acceptance-session-key', (data) {
        print('Data Is : $data');
        AppConstants.secret = AppConstants.random;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: [
            const SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats App',
              style: getBoldStyle(color: ColorManager.light),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              child: Icon(
                Icons.edit,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DefaultFormField(
                controller: searchController,
                label: 'Search',
                prefixIcon: Icons.search,
                validator: (String value) {},
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SizedBox(
              height: 30.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsetsDirectional.only(start: 10.0, end: 5.0),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(allUsersModel.users?[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20.0,
              ),
              itemCount: allUsersModel.users?.length ?? 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChatItem(Users? user) => InkWell(
        onTap: () {
          defaultNavigator(
            context: context,
            widget: ChatScreen(uId: user!.sId!),
          );
        },
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: const [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage(
                    'assets/images/person.png',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: 3.0,
                    end: 3.0,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 7.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username ?? 'Loading user name',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Hello, I\'ll see U tomorrow',
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          decoration: const BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                        ),
                      ),
                      const Text(
                        '02:00 pm',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
