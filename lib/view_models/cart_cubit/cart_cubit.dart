import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  void getcartitems() async {
    emit(CartLoading());
    emit(CartLoaded(dummyCart, _subtotal));
  }

  void incrementcounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);

    emit(QuantityCounterLoaded(value: quantity, productid: productId));
    emit(SubtotalUpdated(_subtotal));
  }

  void decrementcounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity--;
    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(QuantityCounterLoaded(value: quantity, productid: productId));
    emit(SubtotalUpdated(_subtotal));
  }
}

double get _subtotal => dummyCart.fold<double>(
  0,
  (previousValue, item) => previousValue + item.product.price * item.quantity,
);
