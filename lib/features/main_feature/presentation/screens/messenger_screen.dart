// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:m3g_chat/app/components/widgets/defalut_form_field.dart';

import 'chat_screen.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  TextEditingController searchController = TextEditingController();

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
            SizedBox(
              height: 110.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buildStoryItem(),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20.0,
                ),
                itemCount: 10,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsetsDirectional.only(start: 10.0, end: 5.0),
              // This Build All item Once because it part of scrollable Screen
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20.0,
              ),
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStoryItem() => SizedBox(
        width: 60.0,
        child: Column(
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
              height: 6.0,
            ),
            const Text(
              'Muhammad Reza AlRifai',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

  Widget buildChatItem() => InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ChatScreen()),
              (route) => true);
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
                  const Text(
                    'Muhammad AlRifai',
                    style: TextStyle(
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
