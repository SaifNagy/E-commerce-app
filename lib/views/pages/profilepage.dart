import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen: (previous, current) {
            return current is AuthLoggedout || current is AuthLoggingoutError;
          },
          listener: (context, state) {
            if (state is AuthLoggedout) {
              Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(AppRoutes.loginRoute,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoggingout) {
              return MainButton(isLoading: true);
            }
            return MainButton(
              name: 'Logout',
              onTap: () async => cubit.logout(),
            );
          },
        ),
      ),
    );
  }
}
