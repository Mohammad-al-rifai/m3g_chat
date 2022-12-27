import 'package:flutter/material.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/styles_manager.dart';
import '../../../../app/components/widgets/defalut_form_field.dart';
import '../../../../app/components/widgets/default_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Manager'),
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
                    'File manager will save your file in Secure Place',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DefaultFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email-Address',
                    prefixIcon: Icons.email,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Email Address Required!';
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
