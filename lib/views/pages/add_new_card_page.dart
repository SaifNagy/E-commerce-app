import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/views/widgets/label_with_textfield_new_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Add New Card')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWithTextField(
                  label: 'Card Number',
                  controller: _cardNumberController,
                  prefixIcon: CupertinoIcons.creditcard,
                  hintText: 'Enter card number',
                ),
                LabelWithTextField(
                  label: 'Card Holder Name',
                  controller: _cardHolderNameController,
                  prefixIcon: CupertinoIcons.person,
                  hintText: 'Enter card holder name',
                ),
                LabelWithTextField(
                  label: 'Expiry Date',
                  controller: _expiryDateController,
                  prefixIcon: Icons.date_range,
                  hintText: 'Enter expiry date',
                ),
                LabelWithTextField(
                  label: 'CVV',
                  controller: _cvvController,
                  prefixIcon: Icons.password,
                  hintText: 'Enter cvv',
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Card added successfully!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  ),
                  child: const Text('Add Card'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SizedBox {
  const SizedBox();
}
