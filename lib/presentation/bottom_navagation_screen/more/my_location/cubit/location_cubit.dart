import 'dart:async';
import 'dart:convert';

import 'package:custom_marker/marker_icon.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/core/app_toast/appIcons.dart';
import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
import 'package:maharat_ecommerce/core/location/helper.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/address/address_response_model.dart';
import 'package:maharat_ecommerce/network/api_response.dart';
import 'package:maharat_ecommerce/repository/location_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(AppInitLocationState());

  static LocationCubit get(context) => BlocProvider.of(context);
  TextEditingController titleController = TextEditingController();
  bool is_get_location = false;
  AddressResponseModel? addressResponseModel;
  LatLng? latLng;
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  String name = "";
  String  country = "";
  String street = "";
  CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};
  bool isLoadingFullAddress = false;
  String? fullAddress;
  Marker? currentSelectedMarker;
int selectIndex =0;
  getLocationApi(BuildContext context) async {
    // print(data);
    try {
      is_get_location = true;
      emit(LoadingLocationDataStates());
      ApiResponse apiResponse = await LocationRepository.getAddress();
      // print("apiResponse.response.data");
      // print(apiResponse.response!.data.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        is_get_location = false;
        addressResponseModel =
            AddressResponseModel.fromJson(apiResponse!.response!.data);
        emit(SuccessLocationDataStates());
      } else {
        try {
          appToast(
              message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        } catch (e) {
          appToast(
              message: e.toString(), type: ToastType.error, context: context);
        }
        is_get_location = false;
        emit(ErrorLocationDataStates());
      }
    } catch (e) {
      is_get_location = false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorLocationDataStates());
    }
  }
  addLocation(BuildContext context,Map<String,dynamic> data) async {
    // print(data);
    try {
      // is_get_location = true;
      emit(LoadingAddLocationDataStates());
      ApiResponse apiResponse = await LocationRepository.addAddress(data);
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        latLng= null;
        titleController.text = '';
        fullAddress ="";
          getLocationApi(context);

        appToast(
            message: tr(TextApp.success), type: ToastType.success, context: context);
        emit(SuccessAddLocationDataStates());
      } else {
        try {
          appToast(
              message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        } catch (e) {
          appToast(
              message: e.toString(), type: ToastType.error, context: context);
        }
        is_get_location = false;
        emit(ErrorAddLocationDataStates());
      }
    } catch (e) {
      is_get_location = false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorAddLocationDataStates());
    }
  }
  updateLocation(BuildContext context,Map<String,dynamic> data, int addressId) async {
    // print(data);
    try {
      // is_get_location = true;
      emit(LoadingAddLocationDataStates());
      ApiResponse apiResponse = await LocationRepository.updateAddress(addressId,data);
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        latLng= null;
        titleController.text = '';
        fullAddress ="";
        getLocationApi(context);

        appToast(
            message: tr(TextApp.success), type: ToastType.success, context: context);
        emit(SuccessAddLocationDataStates());
      } else {
        try {
          appToast(
              message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        } catch (e) {
          appToast(
              message: e.toString(), type: ToastType.error, context: context);
        }
        is_get_location = false;
        emit(ErrorAddLocationDataStates());
      }
    } catch (e) {
      is_get_location = false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorAddLocationDataStates());
    }
  }
  deleteLocation(BuildContext context ,int addressId) async {
    // print(data);
    try {
      selectIndex = addressId;
      // is_get_location = true;
      emit(LoadingDeleteLocationDataStates());
      ApiResponse apiResponse = await LocationRepository.deleteAddress(addressId);
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        latLng= null;
        titleController.text = '';
        fullAddress ="";
        getLocationApi(context);

        appToast(
            message: tr(TextApp.success), type: ToastType.success, context: context);
        emit(SuccessDeleteLocationDataStates());
      } else {
        try {
          appToast(
              message: apiResponse!.response!.data!["message"],
              type: ToastType.error,
              context: context);
        } catch (e) {
          appToast(
              message: e.toString(), type: ToastType.error, context: context);
        }
        is_get_location = false;
        emit(ErrorDeleteLocationDataStates());
      }
    } catch (e) {
      is_get_location = false;
      appToast(message: e.toString(), type: ToastType.error, context: context);
      emit(ErrorAddLocationDataStates());
    }
  }
  /// map location ///
  // void getCurrentLocation({bool onlyCurrentLocation = false, required BuildContext context}) async {
  //   if (onlyCurrentLocation) {
  //     latLng  = await Helpers.getCurrentLocation(
  //         context: context, isNewestLocation: true);
  //     if (latLng != null) {
  //       GoogleMapController googleMapController = await controller.future;
  //       googleMapController.animateCamera(CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //               target: LatLng(latLng!.latitude, latLng!.longitude),
  //               zoom: 14.4746)));
  //       initialCameraPosition = CameraPosition(
  //           target: LatLng(latLng!.latitude, latLng!.longitude), zoom: 10);
  //       emit(EmptyState());
  //
  //     }
  //     return;
  //   }
  //   latLng = await Helpers.getCurrentLocation(
  //       context: context, isNewestLocation: true);
  //   if (latLng != null) {
  //     initialCameraPosition = CameraPosition(
  //         target: LatLng(latLng!.latitude, latLng!.longitude), zoom: 10);
  //     emit(EmptyState());
  //   } else {
  //     Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
  //     if (lastKnownPosition != null) {
  //       initialCameraPosition = CameraPosition(
  //           target:
  //           LatLng(lastKnownPosition.latitude, lastKnownPosition.longitude),
  //           zoom: 10);
  //       emit(RefreshEmptyState());
  //     } else {
  //       initialCameraPosition = const CameraPosition(
  //           target: LatLng(24.69814423, 46.66919210),
  //           zoom: 10);
  //       // zoom: 14.4746);
  //       emit(RefreshEmptyState());
  //     }
  //   }
  //   // print("objectaaa -------");
  //   onTap(LatLng(initialCameraPosition!.target.latitude, initialCameraPosition!.target.longitude),
  //       context: context);
  // }
  void onTap(LatLng latLng2, {bool getFullAddress = true, required BuildContext context, bool is_edit = true})
  async {
    // print("object add -------");
    if(is_edit) {
      markers = {};
      latLng = latLng2;
      currentSelectedMarker = Marker(
          markerId: const MarkerId('selectedLocation'),
          position: latLng2,
          icon: await MarkerIcon.svgAsset(
              assetName: AppIcons.markerIconTwo,
              context: context,
              size: 50));
      markers.add(currentSelectedMarker!);
      notifyMap();
      if (getFullAddress) {
        isLoadingFullAddress = true;
        emit(EmptyState());
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng2.latitude, latLng2.longitude,
          // localeIdentifier: 'ar_SA'
        );
        if (latLng != null) {
          initialCameraPosition = CameraPosition(
              target: LatLng(latLng!.latitude, latLng!.longitude),
              zoom: 14.4746);
          emit(EmptyState());
        }
        if (placemarks != null) {
          if (placemarks.isNotEmpty) {
            // print(placemarks[0]);
            name = placemarks[0].subAdministrativeArea ?? "";
            // name  =  placemarks[0].name??"";
            // country = placemarks[0].country??"";
            country = placemarks[0].locality ?? "";
            street = placemarks[0].street ?? "";
            if (name != null &&
                name.isNotEmpty &&
                // country != null &&
                // country.isNotEmpty &&
                street != null &&
                street.isNotEmpty) {
              // print(name);
              // print(country);
              // print(street);
              // fullAddress = '$country , $name ';
              fullAddress = '$name , $country , $street';
            } else {
              fullAddress = null;
            }
          }
        } else {
          fullAddress = null;
        }
        isLoadingFullAddress = false;
        emit(EmptyState());
      } else {
        // fullAddress = address!.description;
        emit(EmptyState());
      }
    }
    emit(RefreshEmptyState());
  }


  void notifyMap(){
    emit(EmptyState());
  }





/// 00  // 00 /// 000 //// 000
///
  TextEditingController searchController = TextEditingController();
//
  List<Map<String, dynamic>> placePredictions = [];
//
//   Future<void> searchPlaces(String input) async {
//     if (input.isEmpty) {
//       placePredictions = [];
//       emit(InitialLocationState());
//       return;
//     }
//
//     emit(LoadingSearchPlacesState());
//     try {
//       final response = await Dio().get(
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json',
//         queryParameters: {
//           'input': input,
//           'key': 'AIzaSyD_PHBBva-XISKs-oMN_W4aqT7PgVs72dc',
//           'language': 'ar',
//           // 'components': 'country:eg', // اختيار الدولة
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final predictions = response.data['predictions'] as List;
//         placePredictions = predictions.map((e) => {
//           "description": e['description'],
//           "place_id": e['place_id'],
//         }).toList();
//       } else {
//         placePredictions = [];
//       }
//       emit(SuccessSearchPlacesState());
//     } catch (e) {
//       placePredictions = [];
//       emit(ErrorSearchPlacesState());
//     }
//   }
//
//   Future<void> selectPlace(String placeId, BuildContext context) async {
//     emit(LoadingPlaceDetailsState());
//     try {
//       final response = await Dio().get(
//         'https://maps.googleapis.com/maps/api/place/details/json',
//         queryParameters: {
//           'place_id': placeId,
//           'key': 'AIzaSyD_PHBBva-XISKs-oMN_W4aqT7PgVs72dc',
//           'language': 'ar',
//         },
//       );
//
//       final location = response.data['result']['geometry']['location'];
//       final latLng = LatLng(location['lat'], location['lng']);
//
//       final controllerInstance = await controller.future;
//       controllerInstance.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
//
//       onTap(latLng, context: context, getFullAddress: true);
//       placePredictions = [];
//       searchController.clear();
//       emit(SuccessPlaceDetailsState());
//     } catch (e) {
//       emit(ErrorPlaceDetailsState());
//     }
//   }
//





/// adddd ----------
//   Future<Position?> getCurrentLocation({required BuildContext context}) async {
//     try {
//       // التحقق من تشغيل خدمة الموقع
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         _showLocationServiceDialog(context);
//         return null;
//       }
//
//       // التحقق من الإذن
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           _showPermissionDeniedDialog(context);
//           return null;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         _showPermissionPermanentlyDeniedDialog(context);
//         return null;
//       }
//
//       // الحصول على الموقع
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//         timeLimit: Duration(seconds: 15),
//       );
//
//       return position;
//     } catch (e) {
//       print('خطأ في الحصول على الموقع: $e');
//       return null;
//     }
//   }

// 2. Dialog لطلب تشغيل خدمة الموقع
  void _showLocationServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(TextApp.location_service_disabled)),
        content: Text(tr(TextApp.please_enable_location_service)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr(TextApp.cancel)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: Text(tr(TextApp.settings)),
          ),
        ],
      ),
    );
  }

// 3. Dialog لطلب الإذن
  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(TextApp.location_permission_required)),
        content: Text(tr(TextApp.location_permission_message)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr(TextApp.cancel)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.requestPermission();
            },
            child: Text(tr(TextApp.allow)),
          ),
        ],
      ),
    );
  }
  // Future<Position?> getCurrentLocation({required BuildContext context}) async {
  //   try {
  //     // التحقق من تشغيل خدمة الموقع
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       _showLocationServiceDialog(context);
  //       return null;
  //     }
  //
  //     // التحقق من الإذن
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         _showPermissionDeniedDialog(context);
  //         return null;
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       _showPermissionPermanentlyDeniedDialog(context);
  //       return null;
  //     }
  //
  //     // الحصول على الموقع
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //       timeLimit: Duration(seconds: 15),
  //     );
  //
  //     return position;
  //   } catch (e) {
  //     print('خطأ في الحصول على الموقع: $e');
  //     return null;
  //   }
  // }

// 4. Dialog للإذن المرفوض نهائياً
  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(TextApp.location_permission_denied)),
        content: Text(tr(TextApp.location_permission_permanently_denied_message)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr(TextApp.cancel)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openAppSettings();
            },
            child: Text(tr(TextApp.settings)),
          ),
        ],
      ),
    );
  }

// 5. تحسين method الحذف مع تأكيد
  Future<void> deleteLocationWithConfirmation(BuildContext context, int locationId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(TextApp.delete_location)),
        content: Text(tr(TextApp.delete_location_confirmation)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(tr(TextApp.cancel)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: Text(tr(TextApp.delete)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await deleteLocation(context, locationId);
    }
  }

// 6. Cache للمواقع المحفوظة

// // حفظ المواقع في Cache
//   void cacheLocations() {
//     if (addressResponseModel?.data != null) {
//       final locationsJson = json.encode(
//         addressResponseModel!.data!.map((e) => e.toJson()).toList(),
//       );
//       SharedPreferences.getInstance().then((prefs) {
//         prefs.setString(CACHED_LOCATIONS_KEY, locationsJson);
//       });
//     }
//   }

// // استرجاع المواقع من Cache
//   Future<void> loadCachedLocations() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cachedData = prefs.getString(CACHED_LOCATIONS_KEY);
//
//       if (cachedData != null) {
//         final List<dynamic> locationsJson = json.decode(cachedData);
//         // تحويل إلى نموذج البيانات المطلوب
//         // addressResponseModel = AddressResponseModel.fromCachedJson(locationsJson);
//         emit(SuccessLocationDataStates());
//       }
//     } catch (e) {
//       print('خطأ في تحميل البيانات المحفوظة: $e');
//     }
//   }

// إضافات مطلوبة في LocationCubit للخريطة

// 1. متغير للبحث
  bool isSearching = false;

// 2. مسح نتائج البحث
  void clearSearchResults() {
    placePredictions.clear();
    isSearching = false;
    emit(ClearSearchResultsState());
  }

// 3. تحسين البحث عن الأماكن
  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      clearSearchResults();
      return;
    }

    isSearching = true;
    emit(LoadingSearchPlacesState());

    try {
      // إضافة delay لتقليل عدد الطلبات
      await Future.delayed(Duration(milliseconds: 500));

      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json'
                '?input=${Uri.encodeComponent(query)}'
                '&key=AIzaSyD_PHBBva-XISKs-oMN_W4aqT7PgVs72dc'
                '&language=ar'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          placePredictions = List<Map<String, dynamic>>.from(data['predictions']);
          emit(SuccessSearchPlacesState());
        } else {
          placePredictions.clear();
          emit(ErrorSearchPlacesState());
        }
      } else {
        placePredictions.clear();
        emit(ErrorSearchPlacesState());
      }
    } catch (e) {
      print('خطأ في البحث: $e');
      placePredictions.clear();
      emit(ErrorSearchPlacesState());
    } finally {
      isSearching = false;
    }
  }

// 4. تحسين selectPlace
  Future<void> selectPlace(String placeId, BuildContext context) async {
    try {
      emit(LoadingPlaceDetailsState());

      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json'
                '?place_id=$placeId'
                '&key=AIzaSyD_PHBBva-XISKs-oMN_W4aqT7PgVs72dc'
                '&fields=geometry,formatted_address,name'
                '&language=ar'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final result = data['result'];
          final location = result['geometry']['location'];
          final address = result['formatted_address'] ?? '';
          final name = result['name'] ?? '';

          final newPosition = LatLng(location['lat'], location['lng']);

          // تحديث الموقع
          onTap(newPosition, context: context);

          // تحريك الكاميرا
          animateToPosition(newPosition);

          // تحديث اسم الموقع إذا كان فارغًا
          if (titleController.text.isEmpty && name.isNotEmpty) {
            titleController.text = name;
          }

          emit(SuccessPlaceDetailsState());
        } else {
          emit(ErrorPlaceDetailsState());
        }
      }
    } catch (e) {
      print('خطأ في تفاصيل المكان: $e');
      emit(ErrorPlaceDetailsState());
    }
  }

// 5. تحريك الكاميرا لموقع محدد
  Future<void> animateToPosition(LatLng position) async {
    try {
      final GoogleMapController mapController = await controller.future;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 17.0,
          ),
        ),
      );
    } catch (e) {
      print('خطأ في تحريك الكاميرا: $e');
    }
  }

// 6. تحسين onTap
//   Future<void> onTap(LatLng position, {
//     required BuildContext context,
//     bool getFullAddress = false,
//   }) async {
//     latLng = position;
//
//     // تحديث الماركر
//     markers.clear();
//     markers.add(
//       Marker(
//         markerId: MarkerId('selected_location'),
//         position: position,
//         draggable: true,
//         onDragEnd: (newPosition) {
//           onTap(newPosition, context: context, getFullAddress: true);
//         },
//         icon: await _getCustomMarkerIcon(),
//       ),
//     );
//
//     if (getFullAddress) {
//       await getAddressFromCoordinates(position, context);
//     }
//
//     emit(LocationSelectedState());
//   }

// 7. إنشاء أيقونة مخصصة للماركر
  Future<BitmapDescriptor> _getCustomMarkerIcon() async {
    try {
      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
          AppIcons.markerIcon // أضف صورة مخصصة
      );
    } catch (e) {
      // في حالة عدم وجود الصورة، استخدم الافتراضية
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

// 8. تحسين getAddressFromCoordinates
  Future<void> getAddressFromCoordinates(LatLng position, BuildContext context) async {
    try {
      emit(LoadingAddressState());

      final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json'
                '?latlng=${position.latitude},${position.longitude}'
                '&key=AIzaSyD_PHBBva-XISKs-oMN_W4aqT7PgVs72dc'
                '&language=ar'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          fullAddress = data['results'][0]['formatted_address'];
          emit(SuccessAddressState());
        } else {
          fullAddress = tr(TextApp.unknown_location);
          emit(ErrorAddressState());
        }
      } else {
        fullAddress = tr(TextApp.unknown_location);
        emit(ErrorAddressState());
      }
    } catch (e) {
      print('خطأ في الحصول على العنوان: $e');
      fullAddress = tr(TextApp.unknown_location);
      emit(ErrorAddressState());
    }
  }

// 9. إضافة validation للنموذج
  String validateLocationForm() {
    List<String> errors = [];

    if (titleController.text.trim().isEmpty) {
      errors.add(tr(TextApp.location_name_required));
    }

    if (latLng == null) {
      errors.add(tr(TextApp.location_selection_required));
    }

    if (fullAddress?.isEmpty ?? true) {
      errors.add(tr(TextApp.address_loading_required));
    }

    return errors.join('\n');
  }

}

abstract class LocationStates {}

class AppInitLocationState extends LocationStates {}

class LoadingLocationDataStates extends LocationStates {}

class SuccessLocationDataStates extends LocationStates {}

class ErrorLocationDataStates extends LocationStates {}
class EmptyState extends LocationStates {}
class RefreshEmptyState extends LocationStates {}
class LoadingAddLocationDataStates extends LocationStates {}
class SuccessAddLocationDataStates extends LocationStates {}
class ErrorAddLocationDataStates extends LocationStates {}
class LoadingDeleteLocationDataStates extends LocationStates {}
class SuccessDeleteLocationDataStates extends LocationStates {}
class ErrorDeleteLocationDataStates extends LocationStates {}
class LoadingSearchPlacesState extends LocationStates {}
class SuccessSearchPlacesState extends LocationStates {}
class ErrorSearchPlacesState extends LocationStates {}

class LoadingPlaceDetailsState extends LocationStates {}
class SuccessPlaceDetailsState extends LocationStates {}
class ErrorPlaceDetailsState extends LocationStates {}
class InitialLocationState extends LocationStates {}
// حالات البحث
// class LoadingSearchPlacesState extends LocationStates {}
// class SuccessSearchPlacesState extends LocationStates {}
// class ErrorSearchPlacesState extends LocationStates {}
class ClearSearchResultsState extends LocationStates {}

// // حالات تفاصيل المكان
// class LoadingPlaceDetailsState extends LocationStates {}
// class SuccessPlaceDetailsState extends LocationStates {}
// class ErrorPlaceDetailsState extends LocationStates {}

// حالات العنوان
class LoadingAddressState extends LocationStates {}
class SuccessAddressState extends LocationStates {}
class ErrorAddressState extends LocationStates {}

// حالة اختيار الموقع
class LocationSelectedState extends LocationStates {}

// حالات التحديث
class LoadingUpdateLocationDataStates extends LocationStates {}
class SuccessUpdateLocationDataStates extends LocationStates {}
class ErrorUpdateLocationDataStates extends LocationStates {}