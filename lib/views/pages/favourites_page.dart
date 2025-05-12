import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/favourite_cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteCubit = BlocProvider.of<FavouriteCubit>(context);
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      bloc: favouriteCubit,
      buildWhen: (previous, current) =>
          current is FavouriteLoading ||
          current is FavouriteLoaded ||
          current is FavouriteError,
      builder: (context, state) {
        if (state is FavouriteLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is FavouriteError) {
          return Center(child: Text(state.message));
        } else if (state is FavouriteLoaded) {
          if (state.favouriteProducts.isEmpty) {
            return const Center(child: Text('No favourite products'));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await favouriteCubit.getFavouriteProducts();
              },
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.grey2),
                itemCount: state.favouriteProducts.length,
                itemBuilder: (context, index) {
                  final product = state.favouriteProducts[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.price.toString()),
                    trailing: SizedBox(
                      width: 30,
                      height: 30,
                      child: BlocConsumer<FavouriteCubit, FavouriteState>(
                        bloc: favouriteCubit,
                        listenWhen: (previous, current) =>
                            current is FavouriteRemoving ||
                            current is FavouriteRemoved ||
                            current is FavouriteError,
                        listener: (context, state) {
                          if (state is FavouriteError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          }
                        },
                        buildWhen: (previous, current) =>
                            (current is FavouriteRemoving &&
                                current.productId == product.id) ||
                            (current is FavouriteRemoved &&
                                current.productId == product.id) ||
                            current is FavouriteError,
                        builder: (context, state) {
                          if (state is FavouriteRemoving) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          return IconButton(
                            onPressed: () {
                              favouriteCubit.removeFavourite(product.id);
                            },
                            icon: const Icon(Icons.delete),
                          );
                        },
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product.imgUrl),
                      radius: 35,
                    ),
                  );
                },
              ),
            );
          }
        }

        return const SizedBox();
      },
    );
  }
}
