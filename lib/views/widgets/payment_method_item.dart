import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCardModel paymentCard;
  final VoidCallback onTap;
  const PaymentMethodItem({
    super.key,
    required this.paymentCard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          border: Border.all(color: AppColors.grey3),
        ),
        child: ListTile(
          leading: Image.asset(
            'assets/images/mastercard.png',
            width: 80,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: const Text('MatserCard'),
          subtitle: Text(paymentCard.cardNumber),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
