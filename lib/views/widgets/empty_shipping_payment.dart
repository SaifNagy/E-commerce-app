import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  final String title;
  const EmptyShippingAndPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.addNewCardRoute);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.add, size: 30),
              Text(title, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
