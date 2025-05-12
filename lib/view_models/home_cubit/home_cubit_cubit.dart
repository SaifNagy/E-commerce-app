import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favourite_services.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeServices homeServices = HomeServicesImpl();
  final AuthServices authServices = AuthServicesImpl();
  final FavouriteServices favouriteServices = FavouriteServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final currentuser = authServices.currentUser();
      final products = await homeServices.fetchProducts();
      final carouselItems = await homeServices.fetchCarouselItems();
      final favouriteProducts= await favouriteServices.getFavourite(
        currentuser!.uid,
      );
      final List<ProductItemModel >finalProducts=products.map((product){
        final isfavourite= favouriteProducts.any((item) => item.id == product.id);
        return product.copyWith(isfavourite: isfavourite);
      }).toList();
      emit(
        HomeLoaded(carouselItems: carouselItems, products: finalProducts)
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> setFavourite({
    required ProductItemModel product,
  }) async {
     emit (SetFavouriteLoading(product.id));
    try {
      final currentUser= authServices.currentUser();
      final favouriteProducts = await favouriteServices.getFavourite(currentUser!.uid);
      final isFavourite= favouriteProducts.any((item) => item.id == product.id);
      if(isFavourite){
        await favouriteServices.removeFavourite(
         currentUser.uid,
          product.id,
        );
      }else{
        await favouriteServices.addFavourite(
        currentUser.uid,
         product,
        );
      }
      emit(SetFavouriteSuccess(isFavourite: !isFavourite, productId: product.id));
    } catch (e) {
      emit(SetFavouriteError(message: e.toString(), productId: product.id));
    }
  }
}
