import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/views/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getcartitems();
        return cubit;
      },
      child: Builder(
        builder: (context) {
      final cubit = BlocProvider.of<CartCubit>(context);

          return BlocBuilder<CartCubit, CartState>(
            buildWhen:
                (previous, current) =>
                    current is CartLoading ||
                    current is CartLoaded ||
                    current is Carterror,
            bloc: cubit,
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is CartLoaded) {
                final cartItems = state.cartItems;
                if (cartItems.isEmpty) {
                  return const Center(child: Text('No items in cart'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return CartItemWidget(cartItem: cartItem);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                      const Divider(),
                      BlocBuilder<CartCubit, CartState>(
                        bloc: BlocProvider.of<CartCubit>(context),
                        buildWhen:
                            (previous, current) => current is SubtotalUpdated,
                        builder: (context, subtotalstate) {
                          if (subtotalstate is SubtotalUpdated) {
                            return Column(
                              children: [
                                totalAndSubtotalWidget(
                                  context,
                                  title: 'SubTotal',
                                  amount: subtotalstate.subtotal,
                                ),
                                totalAndSubtotalWidget(
                                  context,
                                  title: 'Shipping',
                                  amount: 10,
                                ),
                                Dash(
                                  dashColor: AppColors.grey3,
                                  length:
                                      MediaQuery.of(context).size.width - 30,
                                ),
                                totalAndSubtotalWidget(
                                  context,
                                  title: 'Total Amount',
                                  amount: subtotalstate.subtotal + 10,
                                ),
                              ],
                            );
                          }
                          return Column(
                            children: [
                              totalAndSubtotalWidget(
                                context,
                                title: 'SubTotal',
                                amount: state.subtotal,
                              ),
                              totalAndSubtotalWidget(
                                context,
                                title: 'Shipping',
                                amount: 10,
                              ),
                              Dash(
                                dashColor: AppColors.grey3,
                                length: MediaQuery.of(context).size.width - 30,
                              ),
                              totalAndSubtotalWidget(
                                context,
                                title: 'Total Amount',
                                amount: state.subtotal + 10,
                              ),
                            ],
                          );
                        },
                      ),
                
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 40,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                            ),
                            onPressed: () => Navigator.of(context,rootNavigator: true).pushNamed(AppRoutes.checkoutRoute,),
                            child: Text(
                              'Checkout',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is Carterror) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            },
          );
        },
      ),
    );
  }
}

Widget totalAndSubtotalWidget(
  context, {
  required String title,
  required double amount,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}
