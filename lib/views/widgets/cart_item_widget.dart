import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/views/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: cartItem.product.imgUrl,
              height: 125,
              width: 125,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    BlocConsumer<CartCubit, CartState>(
                      bloc: cartCubit,
                      listenWhen:
                          (previous, current) =>
                              current is CartItemRemoved ||
                              current is CartItemRemoving ||
                              current is Carterror,
                      listener: (context, state) {
                        if (state is CartItemRemovedError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      buildWhen:
                          (previous, current) =>
                              (current is CartItemRemoving &&
                                  current.productId == cartItem.product.id) ||
                              (current is CartItemRemoved &&
                                  current.productId == cartItem.product.id) ||
                              current is Carterror,
                      builder: (context, state) {
                        if (state is CartItemRemoving) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return IconButton(
                          onPressed: () async {
                            await cartCubit.removeCartItem(cartItem.id);
                          },
                          icon: const Icon(Icons.delete, color: AppColors.red),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text.rich(
                  TextSpan(
                    text: 'Size: ',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
                    children: [
                      TextSpan(
                        text: cartItem.size.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cartCubit,
                  buildWhen:
                      (previous, current) =>
                          current is QuantityCounterLoaded &&
                          current.productid == cartItem.product.id,

                  builder: (context, state) {
                    if (state is QuantityCounterLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            value: state.value,
                            cartItem: cartItem,     
                             cubit: cartCubit,
                          ),

                          Text(
                            '\$ ${state.value * cartItem.product.price}',
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          value: cartItem.quantity,
                            cartItem: cartItem,     
                          cubit: cartCubit,
                          initialValue: cartItem.quantity,
                        ),

                        Text(
                          '\$ ${cartItem.totalPrice.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
