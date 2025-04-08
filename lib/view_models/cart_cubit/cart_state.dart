part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartLoaded extends CartState {
  final double subtotal;
  final List<AddTocartModel> cartItems;
const CartLoaded(this.cartItems,this.subtotal);
}
final class Carterror extends CartState {
  final String message;

const  Carterror(this.message);
}

final class QuantityCounterLoaded extends CartState {
  final String productid;
  final int value; 
  const QuantityCounterLoaded({required this.value, required this.productid});
}

final class SubtotalUpdated extends CartState {
  final double subtotal;
  const SubtotalUpdated(this.subtotal);
}