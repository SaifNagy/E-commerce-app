import 'package:ecommerce_app/utils/app_router.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const CustomBottomNavbar(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
