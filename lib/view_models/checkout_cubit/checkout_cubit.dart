import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  List<AddTocartModel> cartItems = dummyCart;

  void getcartitems() {
    emit(CheckoutLoading());
    final cartitems = dummyCart;
    final subtotal = cartItems.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.product.price * element.quantity),
    );
    final numOfProducts = cartItems.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );
    final chosenPaymentCard = dummypaymentcard.firstWhere(
      (element) => element.ischosen == true,
      orElse: () => dummypaymentcard.first,
    );

    final chosenAddress = dummyLocations.firstWhere(
      (element) => element.ischosen == true,
      orElse: () => dummyLocations.first,
    );

    emit(
      CheckoutLoaded(
        caritems: cartitems,
        total: subtotal + 10,
        numOfProducts: numOfProducts,
        chosenPaymentCard: chosenPaymentCard,
        chosenAddress: chosenAddress,
      ),
    );
  }
}
