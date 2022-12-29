// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/styles_manager.dart';
import '../../../../app/components/widgets/defalut_form_field.dart';
import '../../../../app/components/widgets/default_button.dart';
import '../../../../app/components/widgets/toast_notification.dart';
import '../../../../app/logic/func.dart';
import '../../../../config/di/injector.dart';
import '../../domain/bodies/register_body.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../cubit/auth_cubit/auth_states.dart';
import '../layouts/chat_layout.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final RegisterBody _registerBody = RegisterBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File manager'),
      ),
      body: BlocProvider(
        create: (context) => injector<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is RegisterDoneState) {
              // ===============SAVE TOKEN HERE=================
              AppConstants.token = state.registerModel.token!;
              // ===============================================
              showToast(
                text: 'Register Done Success',
                state: ToastStates.SUCCESS,
              );
              defaultReplaceNavigator(
                  context: context, widget: const ChatLayout());
            }
            if (state is RegisterErrorState) {
              showToast(
                text: 'No Internet Connection-Try Again',
                state: ToastStates.ERROR,
              );
            }
          },
          builder: (context, state) {
            print(state.runtimeType);
            return Center(
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
                          'Register Now',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          height: 15.0,
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
                              _registerBody.username = userNameController.text;
                              _registerBody.phone =
                                  int.parse(phoneController.text);
                              _registerBody.password = passwordController.text;
                              context.read<AuthCubit>().register(
                                    registerBody: _registerBody,
                                  );
                            } else {
                              print('Else');
                            }
                          },
                          text: 'register',
                          isUpperCase: true,
                          isLoading: (state is RegisterLoadingState),
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
            );
          },
        ),
      ),
    );
  }
}
