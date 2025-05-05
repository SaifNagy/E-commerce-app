import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
//import 'package:ecommerce_app/models/category_model.dart';
//import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/views/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen:
          (previous, current) =>
              current is ProductDetailsLoading ||
              current is ProductDetailsLoaded ||
              current is ProductDetailsError,

      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              forceMaterialTransparency: true,
              title: const Text('Product Details'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  height: size.height * 0.52,
                  decoration: BoxDecoration(color: AppColors.grey2),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.1),
                      CachedNetworkImage(
                        imageUrl: product.imgUrl,
                        height: size.height * .3,
                        // fit: BoxFit.contain,
                        width: size.width * 1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.48),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    state.product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: AppColors.yellow,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        state.product.averageRate.toString(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: cubit,
                                buildWhen:
                                    (previous, current) =>
                                        current is ProductDetailsLoaded ||
                                        current is QuantityCounterLoaded,
                                builder: (context, state) {
                                  if (state is QuantityCounterLoaded) {
                                    return CounterWidget(
                                      value: state.value,
                                      productId: product.id,
                                      cubit:
                                          BlocProvider.of<ProductDetailsCubit>(
                                            context,
                                          ),
                                    );
                                  } else if (state is ProductDetailsLoaded) {
                                    return CounterWidget(
                                      value: 1,
                                      productId: productId,
                                      cubit:
                                          BlocProvider.of<ProductDetailsCubit>(
                                            context,
                                          ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Size',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            bloc: cubit,
                            buildWhen:
                                (previous, current) =>
                                    current is SizeSelected ||
                                    current is ProductDetailsLoaded,
                            builder: (context, state) {
                              return Row(
                                children:
                                    Productsize.values
                                        .map(
                                          (size) => Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                              top: 6,
                                            ),
                                            child: InkWell(
                                              onTap:
                                                  () => BlocProvider.of<
                                                    ProductDetailsCubit
                                                  >(context).selectSize(size),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      state is SizeSelected &&
                                                              state.size == size
                                                          ? AppColors.primary
                                                          : AppColors.grey2,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12,
                                                  ),
                                                  child: Text(
                                                    size.name,
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.labelMedium!.copyWith(
                                                      color:
                                                          state is SizeSelected &&
                                                                  state.size == size
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Discription',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.product.discription,
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(color: AppColors.black45),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: '\$',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${state.product.price}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  bloc: cubit,
                                  buildWhen:
                                      (previous, current) =>
                                          current is ProductAddedToCart ||
                                          current is ProductAddingToCart ||
                                          current is ProductDetailsLoaded,
                                  builder: (context, state) {
                                    if (state is ProductAddingToCart) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: AppColors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        onPressed: null,
                                        child:
                                            const CircularProgressIndicator.adaptive(),
                                      );
                                    } else if (state is ProductAddedToCart) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: AppColors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        onPressed: null,
                                        child: const Text('Added to Cart'),
                                      );
                                    }
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        if (cubit.selectedsize != null) {
                                          cubit.addToCart(product.id);
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Please select size',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),

                                      label: Text(
                                        'Add to Cart',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 25,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text('No product found')));
        }
      },
    );
  }
}
