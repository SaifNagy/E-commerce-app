part of 'home_cubit_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({required this.carouselItems, required this.products});

  final List<ProductItemModel> products;
  final List<HomeCarouselItemModel> carouselItems;
}

final class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}

final class SetFavouriteLoading extends HomeState {
  String productId;
  SetFavouriteLoading(this.productId);
}

final class SetFavouriteSuccess extends HomeState {
  SetFavouriteSuccess({required this.isFavourite,required this.productId});
  final String productId;
  final bool isFavourite;
}

final class SetFavouriteError extends HomeState {
  
  SetFavouriteError({required this.message,required this.productId});


  final String message;
    final String productId;

}
