import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
   Productsize? selectedsize;
   int quantity=1;

  void getproductdetails(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(const Duration(seconds: 2), () {
      final selectedProduct = dummyproducts.firstWhere(
        (element) => element.id == id,
      );
      emit(ProductDetailsLoaded(product: selectedProduct));
    });
  }

  void incrementcounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value:quantity));
  }

  void decrementcounter(String productId) {
  quantity--;
    emit(QuantityCounterLoaded(value:quantity));
  }

  void selectSize(Productsize size) {
    selectedsize = size;
    emit(SizeSelected(size: size));
  }

  void addToCart(String productId) {
    emit(ProductAddingToCart());
    final caritem = AddTocartModel(
      id: DateTime.now().toIso8601String(),
      product: dummyproducts.firstWhere((item) => item.id == productId),
      size: selectedsize!,
      quantity: quantity,
    );
dummyCart.add(caritem);
    Future.delayed(const Duration(seconds: 1), () {
      emit(
        ProductAddedToCart(
          productId: productId,
        ),
      );
    });
    //add to cart logic
  }
}
