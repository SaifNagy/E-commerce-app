import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  final CartServices _cartServices = CartServicesImpl();
  final AuthServices _authServices = AuthServicesImpl();

  Future<void> getcartitems() async {
    emit(CartLoading());
    try {
      final currentUser = _authServices.currentUser();
            debugPrint(currentUser!.uid.toString());

      final cartItems = await _cartServices.fetchCartItems(currentUser.uid);

      emit(CartLoaded(cartItems, _subtotal(cartItems)));
    } catch (e) {
      emit(Carterror(e.toString()));
    }
  }

  Future<void> incrementcounter(
    AddToCartModel carItem, [
    int? initialValue,
  ]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final updatedCartItem = carItem.copyWith(quantity: quantity);
    final currentUser = _authServices.currentUser();
    await _cartServices.setCartItem(currentUser!.uid, updatedCartItem);

    emit(
      QuantityCounterLoaded(
        value: quantity,
        productid: updatedCartItem.product.id,
      ),
    );
    final cartItems = await _cartServices.fetchCartItems(currentUser.uid);

    emit(SubtotalUpdated(_subtotal(cartItems)));
  }

  Future<void> decrementcounter(
    AddToCartModel cartItem, [
    int? initialValue,
  ]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity--;
    final updatedCartItem = cartItem.copyWith(quantity: quantity);
    final currentUser = _authServices.currentUser();
    await _cartServices.setCartItem(currentUser!.uid, updatedCartItem);

    emit(
      QuantityCounterLoaded(
        value: quantity,
        productid: updatedCartItem.product.id,
      ),
    );
    final cartItems = await _cartServices.fetchCartItems(currentUser.uid);

    emit(SubtotalUpdated(_subtotal(cartItems)));
  }

  Future<void> removeCartItem(String productId) async {
    emit(CartItemRemoving(productId));
    try {
      final currentUser = _authServices.currentUser();
      await _cartServices.removeCartItem(currentUser!.uid, productId);
      emit(CartItemRemoved(productId));
      final cartItems = await _cartServices.fetchCartItems(currentUser.uid);
      final subtotal = cartItems.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + item.product.price * item.quantity,
      );
      emit(CartLoaded(cartItems, subtotal));
    } catch (e) {
      emit(CartItemRemovedError(e.toString()));
    }
  }
}

double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + item.product.price * item.quantity,
    );
