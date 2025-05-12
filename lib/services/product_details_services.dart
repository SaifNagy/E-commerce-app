import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestroe_services.dart';
import 'package:ecommerce_app/utils/apis_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
  Future<void> addToCard(AddToCartModel cartitem, String userId);
  Future<void> setFavorite(ProductItemModel cartitem, String userId);
  Future<void> removeFavourite( ProductItemModel product, String userId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final FirestoreServices firestoreServices = FirestoreServices.instance;
  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final selectedProduct = await firestoreServices
        .getDocument<ProductItemModel>(
          path: ApisPaths.product(productId),
          builder: (data, documentId) => ProductItemModel.fromMap(data),
        );
    return selectedProduct;
  }

  @override
  Future<void> addToCard(AddToCartModel cartItem, String userId) async =>
      await firestoreServices.setData(
        path: ApisPaths.cartitem(userId, cartItem.id),
        data: (cartItem.toMap()),
      );

  @override
  Future<void> removeFavourite(ProductItemModel cartitem, String userId) async{
    await firestoreServices.deleteData(path: ApisPaths.favouriteProduct(userId, cartitem.id));
   
  }

  @override
  Future<void> setFavorite(ProductItemModel cartitem, String userId) async{
    await firestoreServices.setData(path: ApisPaths.favouriteProduct(userId, cartitem.id), data: cartitem.toMap());
  }
}
