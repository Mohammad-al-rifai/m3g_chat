// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/styles_manager.dart';
import '../../../../app/components/widgets/defalut_form_field.dart';
import '../../../../app/components/widgets/default_button.dart';
import '../../../../app/logic/func.dart';
import '../../../../app/socket_io/socket_io.dart';
import '../../domain/bodies/register_body.dart';
import '../../domain/models/auth_model.dart';
import 'login_screen.dart';
import 'messenger_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var userNameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final RegisterBody _registerBody = RegisterBody();

  AuthModel authModel = AuthModel();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SocketIO.socket?.on('Reg-Success', (data) {
      print('Register Success');
      authModel = AuthModel.fromJson(data);
      print('Token is : ');
      print(authModel.token);
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
  void dispose() {
    super.dispose();
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
                    'Register',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Register Now to chat with your Friends',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    label: 'User Name',
                    prefixIcon: Icons.person,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ' User Name Required!';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DefaultFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    label: 'your Phone',
                    prefixIcon: Icons.call,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Phone Required!';
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
                        _registerBody.username = userNameController.text;
                        _registerBody.phone = int.parse(phoneController.text);
                        _registerBody.password = passwordController.text;
                        SocketIO.socket
                            ?.emit('createUser', _registerBody.toJson());
                      }
                    },
                    text: 'register',
                    isUpperCase: true,
                    isLoading: isLoading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Have Account? ',
                        style: getLightStyle(
                          color: ColorManager.lightGrey,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          defaultReplaceNavigator(
                            context: context,
                            widget: const LoginScreen(),
                          );
                        },
                        child: Text(
                          'Login Now',
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
