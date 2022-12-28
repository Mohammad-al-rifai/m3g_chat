import 'package:flutter/material.dart';
import 'package:m3g_chat/app/logic/func.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/styles_manager.dart';
import '../../../../app/components/widgets/defalut_form_field.dart';
import '../../../../app/components/widgets/default_button.dart';
import '../layouts/chat_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M3G Chat'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'M3G App Will Travel with you over the universe',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DefaultFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    label: 'your Phone',
                    prefixIcon: Icons.email,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Your Phone Required!';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DefaultFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    prefixIcon: Icons.lock,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Password Required!';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        defaultNavigator(
                            context: context, widget: const ChatLayout());
                      } else {
                        print('Else');
                      }
                    },
                    text: 'Login',
                    isUpperCase: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Don\'t Have Account? ',
                        style: getLightStyle(
                          color: ColorManager.lightGrey,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Register Now',
                          style: getMediumStyle(
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
