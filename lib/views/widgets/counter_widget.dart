import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final String? productId;
  final AddToCartModel? cartItem;
  final int value;
  final dynamic cubit;
  final int? initialValue;
  const CounterWidget({
    super.key,
    required this.value,
    this.productId,
    this.cartItem,
    required this.cubit,
    this.initialValue,
  }) : assert(productId != null || cartItem != null);

  Future<void> decrementCounter(dynamic param) async {
    if (initialValue != null) {
      await cubit.decrementcounter(param, initialValue);
    } else {
      await cubit.decrementcounter(param);
    }
  }

  Future<void> incrementCounter(dynamic param) async {
    if (initialValue != null) {
      await cubit.incrementcounter(param, initialValue);
    } else {
      await cubit.incrementcounter(param);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                onPressed:
                    () =>
                        cartItem != null
                            ? decrementCounter(cartItem)
                            : decrementCounter(productId),
                icon: const Icon(Icons.remove),
              ),
              Text(value.toString()),
              IconButton(
                onPressed:
                    () =>
                        cartItem != null
                            ? incrementCounter(cartItem)
                            : incrementCounter(productId),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
