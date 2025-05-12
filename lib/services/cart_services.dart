import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/services/firestroe_services.dart';
import 'package:ecommerce_app/utils/apis_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItems(String userId);
  Future<void> removeCartItem(String userId, String cartItemId);
  Future<void> setCartItem(String userId, AddToCartModel cartItem);
}

class CartServicesImpl implements CartServices {
  final FirestoreServices _firestoreServices = FirestoreServices.instance;
  @override
  Future<List<AddToCartModel>> fetchCartItems(String userId) async =>
      await _firestoreServices.getCollection(
        path: ApisPaths.cartitems(userId),
        builder: (data, documentId) => AddToCartModel.fromMap(data),
      );

  @override
  Future<void> removeCartItem(String userId, String cartItemId) async {
    await _firestoreServices.deleteData(
      path: ApisPaths.cartitem(userId, cartItemId),
    );
  }

  @override
  Future<void> setCartItem(String userId, AddToCartModel cartItem) async {
    await _firestoreServices.setData(
      path: ApisPaths.cartitem(userId, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
