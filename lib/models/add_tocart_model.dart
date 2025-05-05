import 'package:ecommerce_app/models/product_item_model.dart';

class AddTocartModel {
  final String id;
  final ProductItemModel product;
  final Productsize size;
  final int quantity;

  AddTocartModel({
    required this.product,
    required this.id,
    required this.size,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;



  AddTocartModel copyWith({
    String? id,
    ProductItemModel? product,
    Productsize? size,
    int? quantity,
  }) {
    return AddTocartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddTocartModel> dummyCart = [];
