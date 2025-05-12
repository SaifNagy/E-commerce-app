import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/services/home_services.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final HomeServices homeServices = HomeServicesImpl();
  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final categoryitem = await homeServices.fetchcategoryItems();
      emit(CategoriesLoaded(categories: categoryitem));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
