import 'package:ecommerce_app/models/home_carousel_item_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeServices homeServices = HomeServicesImpl();
  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchProducts();
      final carouselItems = dummyHomeCarouselItems;
      emit(
        HomeLoaded(carouselItems: carouselItems, products: products)
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }

    
  }
}
