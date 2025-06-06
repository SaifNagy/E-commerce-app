import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/views/widgets/label_with_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
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
                BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                  listenWhen:
                      (previous, current) =>
                          current is AddNewCardSuccess ||
                          current is AddNewCardFailure,
                  listener: (context, state) {
                    if (state is AddNewCardSuccess) {
                      Navigator.pop(context);
                    } else if (state is AddNewCardFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  bloc: cubit,
                  buildWhen:
                      (previous, current) =>
                          current is AddNewCardLoading ||
                          current is AddNewCardSuccess ||
                          current is AddNewCardFailure,
                  builder: (context, state) {
                    if (state is AddNewCardLoading) {
                      return const ElevatedButton(
                        onPressed: null,

                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.addNewCard(
                            _cardNumberController.text,
                            _cardHolderNameController.text,
                            _expiryDateController.text,
                            _cvvController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text('Add Card'),
                    );
                  },
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
