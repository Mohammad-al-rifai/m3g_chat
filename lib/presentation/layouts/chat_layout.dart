import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../screens/messenger_screen.dart';

class ChatLayout extends StatefulWidget {
  const ChatLayout({Key? key}) : super(key: key);

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  PersistentTabController? _controller;

  List<Widget> _buildScreens() {
    return [
      const ContactsScreen(),
      const ContactsScreen(),
    ];
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble_2),
        title: ("Chats"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: ColorManager.lightGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_2_fill),
        title: ("Contacts"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: ColorManager.lightGrey,
      ),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style4,
      popAllScreensOnTapAnyTabs: true,
      hideNavigationBar: true,
      // Choose the nav bar style with this property.
    );
  }
}
