import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:m3g_chat/app/logic/func.dart';
import 'package:m3g_chat/config/di/injector.dart';
import 'package:m3g_chat/features/main_feature/presentation/cubit/auth_cubit/auth_states.dart';
import 'package:m3g_chat/features/main_feature/presentation/screens/register_screen.dart';

import '../../../../app/components/resources/color_manager.dart';
import '../../../../app/components/resources/styles_manager.dart';
import '../../../../app/components/widgets/defalut_form_field.dart';
import '../../../../app/components/widgets/default_button.dart';
import '../../../../app/components/widgets/toast_notification.dart';
import '../../domain/bodies/login_model.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
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
  LoginBody loginBody = LoginBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M3G Chat'),
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => injector<AuthCubit>(),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is LoginDoneState) {
                // ===============SAVE TOKEN HERE=================
                AppConstants.token = state.loginModel.token!;
                // ===============================================
                defaultReplaceNavigator(context: context, widget: const ChatLayout());
                // ================================
                showToast(
                  text: 'Login Done Success',
                  state: ToastStates.SUCCESS,
                );
              }
              if (state is LoginErrorState) {
                showToast(
                  text: 'No Internet Connection-Try Again',
                  state: ToastStates.ERROR,
                );
              }
            },
            builder: (context, state) {
              print(state.runtimeType);
              return SingleChildScrollView(
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
                              loginBody.phone = int.parse(phoneController.text);
                              loginBody.password = passwordController.text;
                              context
                                  .read<AuthCubit>()
                                  .login(loginBody: loginBody);
                            } else {
                              print('Else');
                            }
                          },
                          text: 'Login',
                          isUpperCase: true,
                          isLoading: (state is LoginLoadingState),
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
                                  widget: RegisterScreen(),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
