import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/views/widgets/label_with_textfield.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Login Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please , login with rigistered account !',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 50),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailcontroller,
                    prefixIcon: Icons.email,
                    hintText: 'Enter your email..',
                  ),
                  const SizedBox(height: 30),
                  LabelWithTextField(
                    label: 'Password',
                    controller: passwordcontroller,
                    prefixIcon: Icons.password,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility),
                    ),
                    hintText: 'Enter your password',
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forget Password ?'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen:
                        (previous, current) =>
                            current is AuthDone || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            current is! AuthDone ||
                            current is! AuthError ||
                            current is! AuthLoading,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(isLoading: true);
                      }
                      return MainButton(
                        name: 'Login ',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.loginWithEmailAndPassword(
                              emailcontroller.text,
                              passwordcontroller.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.registerRoute);
                          },
                          child: const Text('Dont have an account ? Register'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Or using other methods',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 16),

                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen:
                              (previous, current) =>
                                  current is GoogleAuthDone ||
                                  current is GoogleAuthError,
                          listener: (context, state) {
                            if (state is GoogleAuthDone) {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.homeRoute);
                            } else if (state is GoogleAuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          buildWhen:
                              (previous, current) =>
                                  current is GoogleAuthenticating ||
                                  current is! GoogleAuthDone ||
                                  current is! GoogleAuthError,
                          builder: (context, state) {
                            if (state is GoogleAuthenticating) {
                              return SocialMediaButton(isLoading: true);
                            }

                            return SocialMediaButton(
                              text: 'Login with Google',
                              imgUrl:
                                  'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                              onTap: () async {
                                await cubit.authenticateWithGoogle();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        SocialMediaButton(
                          text: 'Login with Facebook',
                          imgUrl:
                              'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                          onTap: () {},
                        ),
                      ],
                    ),
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
