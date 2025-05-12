import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              current is AuthLoggedout || current is AuthLoggingoutError,
          listener: (context, state) {
            if (state is AuthLoggedout) {
              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                AppRoutes.loginRoute,
                (route) => false,
              );
            } else if (state is AuthLoggingoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
          buildWhen: (previous, current) => current is AuthLoggingout,
          builder: (context, state) {
            if (state is AuthLoggingout) {
              return MainButton(
                isLoading: true,
              );
            }
            return MainButton(
              name: 'Logout',
              onTap: () async => await cubit.logout(),
            );
          },
        ),
      ),
    );
  }
}