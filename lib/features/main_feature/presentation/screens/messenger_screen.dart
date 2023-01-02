// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:m3g_chat/app/components/widgets/defalut_form_field.dart';
import 'package:m3g_chat/app/logic/func.dart';
import 'package:m3g_chat/features/main_feature/domain/models/all_users_model.dart';
import 'package:m3g_chat/features/main_feature/presentation/screens/t_chat_screen.dart';

import '../../../../app/socket_io/socket_io.dart';

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
    SocketIO.socket?.emit('getUsers', {
      'token':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2FkOTRkMzA3NzVhYTMyMzhlYWU0MzEiLCJpYXQiOjE2NzI0Nzg3NDZ9.gUxm0IN2fPNKBo3oYaM-KQ1jFIIe_yHPmUKLDV_fUQ8'
    });
    SocketIO.socket?.on('All-Users', (data) {
      print('Get Users Success');
      allUsersModel = AllUsersModel.fromJson(data);
      setState(() {});
    });

    SocketIO.socket?.on('user-in', (data) {
      print('user-in Success');
      print(data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1661917658~exp=1661918258~hmac=cb29f519e16efc09291926fb0f0ea80dcfa028b412e2c568d9299bc28a44906d'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
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
          SocketIO.socket?.emit('new user', {
            'username': user?.username,
            'phone': user?.phone,
            'id': AppConstants.uId,
          });
          defaultNavigator(
            context: context,
            widget: ChatPage(uId: user!.sId!),
          );
        },
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: const [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1661917658~exp=1661918258~hmac=cb29f519e16efc09291926fb0f0ea80dcfa028b412e2c568d9299bc28a44906d'),
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
                    user?.username ?? 'Muhammad AlRifai',
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
                          'Hello My Name Is Muhammad AlRifai Hello My Name Is Muhammad AlRifai Hello My Name Is Muhammad AlRifai',
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
