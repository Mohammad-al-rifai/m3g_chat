import 'package:flutter/material.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:m3g_chat/app/logic/func.dart';
import 'package:m3g_chat/app/socket_io/socket_io.dart';
import 'package:m3g_chat/presentation/screens/register_screen.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/styles_manager.dart';
import '../../../../app/components/widgets/defalut_form_field.dart';
import '../../../../app/components/widgets/default_button.dart';
import '../../domain/bodies/login_body.dart';
import '../../domain/models/auth_model.dart';
import 'messenger_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginBody loginBody = LoginBody();

  AuthModel authModel = AuthModel();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SocketIO.socket?.on('log-Success', (data) {
      print('Login Success');
      authModel = AuthModel.fromJson(data);
      if (authModel.token != null && authModel.user?.sId != null) {
        AppConstants.token = authModel.token!;
        AppConstants.uId = authModel.user!.sId!;
        AppConstants.phone = authModel.user!.phone!;
        AppConstants.username = authModel.user!.username!;
      }

      SocketIO.socket!.io.options['extraHeaders'] = {
        'token': 'Bearer ${authModel.token!}'
      }; // Update the extra headers.
      SocketIO.socket!.io
        ..disconnect()
        ..connect(); // Reconnect the socket manually.

      defaultReplaceNavigator(context: context, widget: const ContactsScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To Chat App'),
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
                    'Login now to chat with your Friends',
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
                    height: 20.0,
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
                        setState(() {
                          isLoading = !isLoading;
                        });
                        loginBody.phone = int.parse(phoneController.text);
                        loginBody.password = passwordController.text;

                        SocketIO.socket?.emit('login', loginBody.toJson());
                      }
                    },
                    text: 'Login',
                    isUpperCase: true,
                    isLoading: isLoading,
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
                        onPressed: () {
                          defaultReplaceNavigator(
                            context: context,
                            widget: const RegisterScreen(),
                          );
                        },
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
