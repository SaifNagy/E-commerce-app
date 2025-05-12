import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestroe_services.dart';
import 'package:ecommerce_app/utils/apis_paths.dart';

abstract class FavouriteServices {
  Future<void> addFavourite(String userId, ProductItemModel product);
  Future<void> removeFavourite(String userId, String product);
  Future<List<ProductItemModel>> getFavourite(String userId);
}

final firestoreServices = FirestoreServices.instance;

class FavouriteServicesImpl implements FavouriteServices {
  @override
  Future<void> addFavourite(String userId, ProductItemModel product) async {
    await firestoreServices.setData(
      path: ApisPaths.favouriteProduct(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<List<ProductItemModel>> getFavourite(String userId) async =>
      await firestoreServices.getCollection(
        path: ApisPaths.favouriteProducts(userId),
        builder: (data, documentId) => ProductItemModel.fromMap(data),
      );

  @override
  Future<void> removeFavourite(String userId, String productId) async {
    await firestoreServices.deleteData(
      path: ApisPaths.favouriteProduct(userId, productId),
    );
  }
}
