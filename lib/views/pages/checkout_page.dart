import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/views/widgets/checkout_headlines_item.dart';
import 'package:ecommerce_app/views/widgets/empty_shipping_payment.dart';
import 'package:ecommerce_app/views/widgets/payment_method_bottom_sheet.dart';
import 'package:ecommerce_app/views/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPaymentMethodItem(
    PaymentCardModel? chosencard,
    BuildContext context,
  ) {
    if (chosencard != null) {
      return PaymentMethodItem(
        paymentCard: chosencard,
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .55,
                width: double.infinity,
                child: BlocProvider(
                  create: (context) {
                    final cubit = PaymentMethodsCubit();
                    cubit.fetchPaymentMethods();
                    return cubit;
                  },
                  child: const PaymentMethodBottomSheet(),
                ),
              );
            },
          ).then(
            (value) => BlocProvider.of<CheckoutCubit>(context).getcartitems(),
          );
        },
      );
    } else {
      return const EmptyShippingAndPayment(
        isPayment: true,
        title: 'Add Payment Method',
      );
    }
  }

  Widget __buildShippingItem(
    LocationItemModel? chosenAddress,
    BuildContext context,
  ) {
    if (chosenAddress != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: chosenAddress.imgUrl,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chosenAddress.city,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              Text(
                '${chosenAddress.city}, ${chosenAddress.country}',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ],
      );
    } else {
      return const EmptyShippingAndPayment(
        isPayment: false,
        title: 'Add Shipping Address',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckoutCubit();
        cubit.getcartitems();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Checkout')),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen:
                  (previous, current) =>
                      current is CheckoutLoading ||
                      current is CheckoutLoaded ||
                      current is CheckoutError,

              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is CheckoutError) {
                  return Center(child: Text(state.message));
                } else if (state is CheckoutLoaded) {
                  final chosenPaymentCard = state.chosenPaymentCard;
                  final caritems = state.caritems;
                  final chosenAddress = state.chosenAddress;
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Column(
                          children: [
                            CheckoutHeadlinesItem(
                              title: 'Address',
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.chooseLocation)
                                    .then((value) => cubit.getcartitems());
                              },
                            ),
                            const SizedBox(height: 16),
                            __buildShippingItem(chosenAddress, context),
                            const SizedBox(height: 30),
                            CheckoutHeadlinesItem(
                              title: 'Products',
                              numOfProducts: state.numOfProducts,
                            ),
                            const SizedBox(height: 16),
                            ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: caritems.length,
                              itemBuilder: (context, index) {
                                final cartitem = caritems[index];
                                return Row(
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey2,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: cartitem.product.imgUrl,
                                        height: 125,
                                        width: 125,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartitem.product.name,
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: 'Size: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        color: AppColors.grey,
                                                      ),
                                                  children: [
                                                    TextSpan(
                                                      text: cartitem.size.name,
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '\$ ${cartitem.totalPrice}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            const CheckoutHeadlinesItem(
                              title: 'Payment Methods',
                            ),
                            const SizedBox(height: 16),
                            _buildPaymentMethodItem(chosenPaymentCard, context),
                            const SizedBox(height: 16),
                            Divider(color: AppColors.grey2),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.grey),
                                ),
                                Text(
                                  '\$ ${state.total.toStringAsFixed(1)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                ),
                                onPressed: () => () {},
                                child: Text(
                                  'Procced to Buy',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('Something Went Wrong'));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
