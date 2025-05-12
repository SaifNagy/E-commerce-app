import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/view_models/favourite_cubit/favourite_cubit.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productitem;
  const ProductItem({super.key, required this.productitem});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final favouriteCubit = BlocProvider.of<FavouriteCubit>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 125,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: productitem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder:
                      (context, url) => const Center(
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white54,
                  shape: BoxShape.circle,
                ),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  buildWhen:
                      (previous, current) =>
                          (current is SetFavouriteSuccess &&
                              current.productId == productitem.id) ||
                          (current is SetFavouriteLoading &&
                              current.productId == productitem.id) ||
                          (current is SetFavouriteError &&
                              current.productId == productitem.id),
                  builder: (context, state) {
                    if (state is SetFavouriteLoading) {
                      return const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else if (state is SetFavouriteSuccess) {
                      return state.isFavourite
                          ? InkWell(
                            onTap: () async {
                              await homeCubit.setFavourite(
                                product: productitem,
                              );
                            },
                            child: const Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
                            ),
                          )
                          : InkWell(
                            onTap: () async {
                              await homeCubit.setFavourite(
                                product: productitem,
                              );

                            },
                            child: const Icon(CupertinoIcons.heart),
                          );
                    }
                    return InkWell(
                      onTap:
                          () async { await homeCubit.setFavourite(
                            product: productitem,
                          );
                    favouriteCubit.getFavouriteProducts();
},
                      child:
                          productitem.isfavourite
                              ? const Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                              )
                              : const Icon(CupertinoIcons.heart),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          productitem.name,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          productitem.category,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: Colors.grey),
        ),
        Text(
          '\$ ${productitem.price}',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
