import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImpl();
  final cartServices = CartServicesImpl();


  Future<void> getcartitems() async {
    emit(CheckoutLoading());
    try {
      final currentUser = authServices.currentUser();
      final cartItems = await cartServices.fetchCartItems(currentUser!.uid);
      final subtotal = cartItems.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.product.price * element.quantity),
      );
      final numOfProducts = cartItems.fold(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );
      final chosenPaymentCard =
          (await checkoutServices.fetchPaymentMethods(currentUser.uid, true))
              .first;
      final chosenAddress = dummyLocations.firstWhere(
        (element) => element.ischosen == true,
        orElse: () => dummyLocations.first,
      );

      emit(
        CheckoutLoaded(
          caritems: cartItems,
          total: subtotal + 10,
          numOfProducts: numOfProducts,
          chosenPaymentCard: chosenPaymentCard,
          chosenAddress: chosenAddress,
        ),
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
    
  }
}
