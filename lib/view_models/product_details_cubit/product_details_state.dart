part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLoaded({required this.product});
}

final class ProductDetailsError extends ProductDetailsState {
  ProductDetailsError({required this.message});
  final String message;
}

final class QuantityCounterLoaded extends ProductDetailsState {

  final int value;
  QuantityCounterLoaded({required this.value});
}

final class SizeSelected extends ProductDetailsState {
  final Productsize size;
  SizeSelected({required this.size});
}

final class ProductAddedToCart extends ProductDetailsState {
  final String productId;
  ProductAddedToCart({required this.productId});
}
final class ProductAddingToCart extends ProductDetailsState {

}
