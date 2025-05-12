import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favourite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final favouriteServices = FavouriteServicesImpl();
  final authServices = AuthServicesImpl();
  Future<void> getFavouriteProducts() async {
    emit(FavouriteLoading());
    try {
      final currentUser = authServices.currentUser();
      final favouriteProducts = await favouriteServices.getFavourite(
        currentUser!.uid,
      );
      emit(FavouriteLoaded(favouriteProducts: favouriteProducts));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> removeFavourite(String productId) async {
    emit(FavouriteRemoving(productId: productId));
    try {
      final currentUser = authServices.currentUser();
      await favouriteServices.removeFavourite(currentUser!.uid, productId);
      emit(FavouriteRemoved(productId: productId));
      final favouriteProducts = await favouriteServices.getFavourite(
        currentUser.uid,
      );
      emit(FavouriteLoaded(favouriteProducts: favouriteProducts));
    } catch (e) {
      emit(FavouriteRemoveError(e.toString()));
    }
  }


  
}
