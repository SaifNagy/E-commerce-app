part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}

final class AddNewCardLoading extends PaymentMethodsState {}

final class AddNewCardSuccess extends PaymentMethodsState {}

final class AddNewCardFailure extends PaymentMethodsState {
  final String errorMessage;
  AddNewCardFailure({required this.errorMessage});
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCardModel> paymentMethods;
  FetchedPaymentMethods({required this.paymentMethods});
}
final class FetchingPaymentMethodsError extends PaymentMethodsState {
  final String errorMessage;
  FetchingPaymentMethodsError({required this.errorMessage});
}

final class PaymentMethodChosen extends PaymentMethodsState {
  final PaymentCardModel chosenPayment;
  PaymentMethodChosen( this.chosenPayment);
}
final class ConfirmPaymentLoading extends PaymentMethodsState {}

final class ConfirmPaymentSuccess extends PaymentMethodsState {}

final class ConfirmPaymentFailure extends PaymentMethodsState {
  final String errorMessage;
  ConfirmPaymentFailure({required this.errorMessage});
}