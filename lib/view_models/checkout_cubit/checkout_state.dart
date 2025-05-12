part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> caritems;
  final double total;
  final int numOfProducts;
  PaymentCardModel? chosenPaymentCard;
  final LocationItemModel? chosenAddress;

  CheckoutLoaded({
    required this.caritems,
    required this.total,
    required this.numOfProducts,
    this.chosenPaymentCard,
    this.chosenAddress,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError( this.message);
}
