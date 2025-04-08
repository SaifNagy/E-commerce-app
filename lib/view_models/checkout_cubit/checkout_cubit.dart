import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  List<AddTocartModel> cartItems = dummyCart;

  void getcartitems() {
    emit(CheckoutLoading());
    _emitUpdatedState();
  }

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity < 0) return; // منع القيم السالبة
    cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
    _emitUpdatedState();
  }

  void _emitUpdatedState() {
    final subtotal = cartItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.product.price * element.quantity),
    );

    final numOfProducts = cartItems.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );

    emit(
      CheckoutLoaded(
        caritems: List.from(cartItems), // عمل نسخة جديدة لتجنب التعديلات المباشرة
        total: subtotal + 10, // 10 قيمة الشحن
        numOfProducts: numOfProducts,
      ),
    );
  }
}
