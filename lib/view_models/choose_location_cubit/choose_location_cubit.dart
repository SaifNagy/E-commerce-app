import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/location_item_model.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String selectedLocationId = dummyLocations.first.id;
  final authServices = AuthServicesImpl();
  final locationServices = LocationServicesImpl();

  void fetchLocations() {
    emit(FetchingLocations());
    Future.delayed(const Duration(seconds: 1), () {
      emit(FetchedLocations(dummyLocations));
    });
  }

  Future<void> addLocation(String location) async {
    emit(AddingLocations());
    try {
      final splittedLocations = location.split('-');
      final locationItem = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: splittedLocations[0],
        country: splittedLocations[1],
      );
      final currentUser = authServices.currentUser();
      await locationServices.setLocation(locationItem, currentUser!.uid);
      emit(LocationAdded());
      // final locations = await locationServices.fetchLocations(currentUser.uid);
      emit(FetchedLocations(dummyLocations));
    } catch (e) {
      emit(LocationAddingFailure(e.toString()));
    }
  }

  void selectLocation(String locationId) {
    selectedLocationId = locationId;
    final chosenlocation = dummyLocations.firstWhere(
      (location) => location.id == selectedLocationId,
    );
    emit(LocationChosen(chosenlocation));
  }

  void confirmAddress() {
    emit(ConfirmAddressLoading());
    Future.delayed(const Duration(seconds: 1), () {
      var chosenAddress = dummyLocations.firstWhere(
        (location) => location.id == selectedLocationId,
      );
      var previousLocation = dummyLocations.firstWhere(
        (location) => location.ischosen == true,
        orElse: () => dummyLocations.first,
      );
      previousLocation = previousLocation.copyWith(ischosen: false);
      chosenAddress = chosenAddress.copyWith(ischosen: true);

      final chosenIndex = dummyLocations.indexWhere(
        (location) => location.id == chosenAddress.id,
      );
      final previousIndex = dummyLocations.indexWhere(
        (location) => location.id == previousLocation.id,
      );
      dummyLocations[previousIndex] = previousLocation;
      dummyLocations[chosenIndex] = chosenAddress;

      emit(ConfirmAddressLoaded());
    });
  }
}
