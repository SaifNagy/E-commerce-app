import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/location_item_model.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String? selectedLocationId;
  LocationItemModel? selectedLocation;
  final authServices = AuthServicesImpl();
  final locationServices = LocationServicesImpl();

  Future<void> fetchLocations() async {
    emit(FetchingLocations());

    try {
      final currentUser = authServices.currentUser();
      final locations = await locationServices.fetchLocations(currentUser!.uid);
      for (var location in locations) {
        if (location.ischosen) {
          selectedLocationId = location.id;
          selectedLocation = location;
        }
      }
      selectedLocationId ??= locations.first.id;
      selectedLocation ??= locations.first;
      emit(FetchedLocations(locations));
      emit(LocationChosen(selectedLocation!));
    } catch (e) {
      emit(FetchLocationFailure(e.toString()));
    }
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
      final locations = await locationServices.fetchLocations(currentUser.uid);
      emit(FetchedLocations(locations));
    } catch (e) {
      emit(LocationAddingFailure(e.toString()));
    }
  }

  Future<void> selectLocation(String id) async {
    final currentUser = authServices.currentUser();
    selectedLocationId = id;
    final chosenlocation =
        await locationServices.fetchSingleLocation(currentUser!.uid, id);
    selectedLocation = chosenlocation;
    emit(LocationChosen(chosenlocation));
  }

  Future<void> confirmAddress() async {
    emit(ConfirmAddressLoading());
    try {
      final currentUser = authServices.currentUser();
      var previousChosenLocation =
          (await locationServices.fetchLocations(currentUser!.uid, true));
      if (previousChosenLocation.isNotEmpty) {
        var previousLocation = previousChosenLocation.first;
        previousLocation = previousLocation.copyWith(ischosen: false);
        selectedLocation = selectedLocation!.copyWith(ischosen: true);
       await locationServices.setLocation(previousLocation, currentUser.uid);
        await locationServices.setLocation(selectedLocation!, currentUser.uid);
      }


      emit(ConfirmAddressLoaded());
    } catch (e) {
      emit(ConfirmAddressFailure(e.toString()));
    }
  }
}
