part of 'favourite_cubit.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoading extends FavouriteState {}

final class FavouriteLoaded extends FavouriteState {
  final List<ProductItemModel> favouriteProducts;
  FavouriteLoaded({required this.favouriteProducts});
}

final class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}

final class FavouriteRemoved extends FavouriteState {
  final String productId;
  FavouriteRemoved({required this.productId});
}

final class FavouriteRemoving extends FavouriteState {final String productId;
  FavouriteRemoving({required this.productId});}

final class FavouriteRemoveError extends FavouriteState {
  final String message;
  FavouriteRemoveError(this.message);
}

