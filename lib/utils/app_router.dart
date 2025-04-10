import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/pages/add_new_card_page.dart';
import 'package:ecommerce_app/views/pages/checkout_page.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_navbar.dart';
import 'package:ecommerce_app/views/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    settings.name;
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const CustomBottomNavbar(),
          settings: settings
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (context) => const CheckoutPage(),
          settings: settings
        );
case AppRoutes.addNewCardRoute:
        return MaterialPageRoute(
          builder: (context) => const AddNewCardPage(),
          settings: settings
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
