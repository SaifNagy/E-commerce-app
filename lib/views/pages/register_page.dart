import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/views/widgets/label_with_textfield.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start shopping with create your account!',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Username',
                    controller: usernameController,
                    prefixIcon: Icons.person,
                    hintText: 'Enter you username',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Enter you email',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Password',
                    controller: passwordController,
                    prefixIcon: Icons.password,
                    hintText: 'Enter you password',
                    obsecureText: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 40),
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
                            current is AuthDone ||
                            current is AuthError ||
                            current is AuthLoading,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(isLoading: true);
                      }
                      return MainButton(
                        name: 'Create Account',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.registerWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                              usernameController.text,
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
                            Navigator.of(context).pop();
                          },
                          child: const Text('You have an account? Login'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Or using other method',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 16),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) => 
                              current is GoogleAuthDone ||
                              current is GoogleAuthError,
                          listener: (context, state) {
                            if(state is GoogleAuthDone){
                              Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                            }else if(state is GoogleAuthError){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },buildWhen: (previous, current) => 
                              current is! GoogleAuthDone ||
                              current is! GoogleAuthError ||
                              current is! AuthLoading,
                          builder: (context, state) {
                            if (state is AuthLoading) 
                            {return SocialMediaButton(
                              isLoading: true,
                            );
                            }
                            return SocialMediaButton(
                              text: 'SignUp with Google',
                              imgUrl:
                                  'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                              onTap: () async {
                                cubit.authenticateWithGoogle();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        SocialMediaButton(
                          text: 'SignUp with Facebook',
                          imgUrl:
                              'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
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
