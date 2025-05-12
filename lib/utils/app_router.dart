import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/choose_location_cubit/choose_location_cubit.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/pages/add_new_card_page.dart';
import 'package:ecommerce_app/views/pages/checkout_page.dart';
import 'package:ecommerce_app/views/pages/choose_location_page.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_navbar.dart';
import 'package:ecommerce_app/views/pages/login_page.dart';
import 'package:ecommerce_app/views/pages/product_details_page.dart';
import 'package:ecommerce_app/views/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    settings.name;
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const CustomBottomNavbar(),
          settings: settings,
        );
      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthCubit(),
                child: const LoginPage(),
              ),
          settings: settings,
        );
      case AppRoutes.registerRoute:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => AuthCubit(),
                child: const RegisterPage(),
              ),
          settings: settings,
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (context) => const CheckoutPage(),
          settings: settings,
        );
      case AppRoutes.chooseLocation:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) {
                  final cubit = ChooseLocationCubit();
                  cubit.fetchLocations();
                  return cubit;
                },
                child: const ChooseLocationPage(),
              ),
          settings: settings,
        );
      case AppRoutes.addNewCardRoute:
        final paymentMethodsCubit = settings.arguments as PaymentMethodsCubit;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: paymentMethodsCubit,
                child: const AddNewCardPage(),
              ),
          settings: settings,
        );

      case AppRoutes.productDetailRoute:
        final String productid = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) {
                final cubit = ProductDetailsCubit();
                cubit.getproductdetails(productid);
                return cubit;
              },
              child: ProductDetailsPage(productId: productid),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
