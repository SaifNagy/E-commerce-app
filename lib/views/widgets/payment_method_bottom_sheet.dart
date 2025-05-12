import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final paymentMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, top: 36, bottom: 16),
          child: Column(
            children: [
              // SizedBox(height: size.height * .04),
              Text(
                'Payment Methods',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: BlocProvider.of<PaymentMethodsCubit>(context),
                buildWhen: (previous, current) =>
                    current is FetchedPaymentMethods ||
                    current is FetchingPaymentMethods ||
                    current is FetchPaymentMethodsError,
                builder: (_, state) {
                  if (state is FetchingPaymentMethods) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is FetchedPaymentMethods) {
                    final paymentCards = state.paymentCards;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.paymentCards.length,
                      itemBuilder: (_, index) {
                        final paymentCard = paymentCards[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              paymentMethodsCubit.changePaymentMethod(
                                paymentCard.id,
                              );
                            },
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 8,
                                ),
                                child: Image.asset(
                                  'assets/images/mastercard.png',
                                  height: 31,
                                ),
                              ),
                            ),
                            title: Text(paymentCard.cardNumber),
                            subtitle: Text(paymentCard.cardHolderName),
                            trailing: BlocBuilder<PaymentMethodsCubit,
                                PaymentMethodsState>(
                              bloc: paymentMethodsCubit,
                              buildWhen: (previous, current) =>
                                  current is PaymentMethodChosen,
                              builder: (context, state) {
                                if (state is PaymentMethodChosen) {
                                  final chosenPaymentMethod =
                                      state.chosenPayment;
                                  return Radio<String>(
                                    value: paymentCard.id,
                                    groupValue: chosenPaymentMethod.id,
                                    onChanged: (id) {
                                      paymentMethodsCubit.changePaymentMethod(
                                        id!,
                                      );
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is FetchPaymentMethodsError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.addNewCardRoute,
                          arguments: paymentMethodsCubit)
                      .then(
                          (value) => paymentMethodsCubit.fetchPaymentMethods());
                },
                child: Card(
                  child: ListTile(
                    leading: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey2,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.add),
                      ),
                    ),
                    title: const Text('Add Payment Method'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                bloc: paymentMethodsCubit,
                listenWhen: (previous, current) =>
                    current is ConfirmPaymentSuccess,
                buildWhen: (previous, current) =>
                    current is ConfirmPaymentLoading ||
                    current is ConfirmPaymentSuccess ||
                    current is ConfirmPaymentFailure,
                listener: (context, state) {
                  if (state is ConfirmPaymentSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is ConfirmPaymentLoading) {
                    return MainButton(
                      isLoading: true,
                      onTap: null,
                    );
                  }

                  return MainButton(
                    name: 'Confirm Payment',
                    onTap: ()  async{await 
                       paymentMethodsCubit.confirmPaymentMethod();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
