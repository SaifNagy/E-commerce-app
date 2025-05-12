import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  final String title;
  final bool isPayment;
  const EmptyShippingAndPayment({
    super.key,
    required this.title,
    required this.isPayment,
  });

  @override
  Widget build(BuildContext context) {
    final checkoutcubit = BlocProvider.of<CheckoutCubit>(context);
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return InkWell(
      onTap: () {
        if (isPayment == true) {
          Navigator.of(context)
              .pushNamed(AppRoutes.addNewCardRoute,arguments: paymentMethodsCubit)
              .then((value)async => await checkoutcubit.getcartitems());
        } else {
          Navigator.of(context).pushNamed(AppRoutes.chooseLocation);
        }
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
