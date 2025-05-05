import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestroe_services.dart';
import 'package:ecommerce_app/utils/apis_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemModel>(
      path: ApisPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
    );
    return result;
  }
}
