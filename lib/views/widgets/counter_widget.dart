import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final String productId;
  final int value;
  final dynamic cubit;
  final int? initialValue;
  const CounterWidget({
    super.key,
    required this.value,
    required this.productId,
    required this.cubit,
     this.initialValue
  });

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
                onPressed: () => initialValue!=null? cubit.decrementcounter(productId,initialValue):cubit.decrementcounter(productId),
                icon: const Icon(Icons.remove),
              ),
              Text(value.toString()),
              IconButton(
                onPressed: () => initialValue!=null? cubit.incrementcounter(productId,initialValue): cubit.incrementcounter(productId,),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
