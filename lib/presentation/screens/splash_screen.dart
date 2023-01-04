import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/components/resources/assets_manager.dart';
import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/constants_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/logic/func.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(
      const Duration(
        seconds: AppConstants.splashDelay,
      ),
      _goNext,
    );
  }

  _goNext() {
    defaultReplaceNavigator(
      context: context,
      widget: const LoginScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.light,
      body: Center(
        child: Lottie.asset(
          JsonAssets.splashScreen,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
