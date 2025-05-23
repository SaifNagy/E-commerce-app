import 'package:ecommerce_app/models/location_item_model.dart';
import 'package:ecommerce_app/services/firestroe_services.dart';
import 'package:ecommerce_app/utils/apis_paths.dart';


abstract class LocationServices {
  Future<List<LocationItemModel>> fetchLocations(String userId,
      [bool chosen = false]);
  Future<void> setLocation(LocationItemModel location, String userId);
  Future<LocationItemModel> fetchSingleLocation(String userId, String locationId);
}

class LocationServicesImpl implements LocationServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> setLocation(LocationItemModel location, String userId) async =>
      await firestoreServices.setData(
        path: ApisPaths.location(userId, location.id),
        data: location.toMap(),
      );

  @override
  Future<List<LocationItemModel>> fetchLocations(String userId,
          [bool chosen = false]) async =>
      await firestoreServices.getCollection(
        path: ApisPaths.locations(userId),
        builder: (data, documentId) => LocationItemModel.fromMap(data),
        queryBuilder:
            chosen ? (query) => query.where('ischosen', isEqualTo: true) : null,
      );

  @override
  Future<LocationItemModel> fetchSingleLocation(
          String userId, String locationId) async =>
      await firestoreServices.getDocument(
        path: ApisPaths.location(userId, locationId),
        builder: (data, documentId) => LocationItemModel.fromMap(data),
      );
}