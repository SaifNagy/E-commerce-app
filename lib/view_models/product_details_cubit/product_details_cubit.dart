import 'package:ecommerce_app/models/add_tocart_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  Productsize? selectedsize;
  int quantity = 1;

  final ProductDetailsServices productDetailsServices =
      ProductDetailsServicesImpl();
  final AuthServices authServices = AuthServicesImpl();

  void getproductdetails(String id) async {
    emit(ProductDetailsLoading());
    try {
      final selectedProduct = await productDetailsServices.fetchProductDetails(
        id,
      );
      
      emit(ProductDetailsLoaded(product: selectedProduct));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  void selectSize(Productsize size) {
    selectedsize = size;
    emit(SizeSelected(size: size));
  }

  Future<void> addToCart(String productId) async {
    emit(ProductAddingToCart());
    try {
     final currentUser = authServices.currentUser();
      final selectedProduct = await productDetailsServices.fetchProductDetails(
        productId,
      );
      final caritem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: selectedProduct,
        size: selectedsize!,
        quantity: quantity,
      );
      await productDetailsServices.addToCard(caritem, currentUser!.uid);

      emit(ProductAddedToCart(productId: productId));
    } catch (e) {
      emit(ProductAddToCartError(e.toString()));
    }
  }

  void incrementcounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementcounter(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }

Future <void> setFavourite(ProductItemModel product) async {
    emit(ProductAddingToFavourites());
    try {
      final currentUser = authServices.currentUser();
      await productDetailsServices.setFavorite(product, currentUser!.uid);
      emit(ProductAddedToFavourites());
    } catch (e) {
      emit(ProductAddToFavouritesError(e.toString()));
    }
  }

  Future <void> removeFavourite(ProductItemModel product) async {
    emit(ProductAddingToFavourites());
    try {
      final currentUser = authServices.currentUser();
      await productDetailsServices.removeFavourite(product, currentUser!.uid);
      emit(ProductAddedToFavourites());
    } catch (e) {
      emit(ProductAddToFavouritesError(e.toString()));
    }
  }

}
