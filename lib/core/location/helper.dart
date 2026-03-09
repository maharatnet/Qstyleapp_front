import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Helpers{
  // static Future<LatLng?> getCurrentLocation({
  //   required BuildContext context,
  //   bool isNewestLocation = false,
  // }) async {
  //   // List<Placemark> newPlace = await placemarkFromCoordinates(AppShared.currentLocation!.latitude, AppShared.currentLocation!.longitude);
  //   // Placemark placeMark  = newPlace[0];
  //   // String? name = placeMark.name;
  //   // String? subLocality = placeMark.subLocality;
  //   // String? locality = placeMark.locality;
  //   // String? administrativeArea = placeMark.administrativeArea;
  //   // String? postalCode = placeMark.postalCode;
  //   // String? country = placeMark.country;
  //   // String? street = placeMark.street;
  //   // print(street);
  //   // if (!isNewestLocation && AppShared.currentLocation != null)
  //   //   return AppShared.currentLocation;
  //   LocationPermission locationPermission = await Geolocator.checkPermission();
  //   if (locationPermission == LocationPermission.denied ||
  //       locationPermission == LocationPermission.deniedForever) {
  //     locationPermission = await Geolocator.requestPermission();
  //   }
  //   if (locationPermission == LocationPermission.always ||
  //       locationPermission == LocationPermission.whileInUse) {
  //     if (Platform.isIOS) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) => Material(
  //           color: Colors.transparent,
  //           child: Container(
  //             color: Colors.transparent,
  //             alignment: Alignment.center,
  //             child: const CircularProgressIndicator(),
  //           ),
  //         ),
  //       );
  //       Position locationData = await Geolocator.getCurrentPosition();
  //       // N.back();
  //       Navigator.pop(context);
  //       return  LatLng(
  //         locationData.latitude,
  //         locationData.longitude,
  //       );
  //     }
  //     bool isGps = await Geolocator.isLocationServiceEnabled();
  //     if (isGps) {
  //       showDialog(
  //         context: context,
  //         builder: (_) => Material(
  //           color: Colors.transparent,
  //           child: Container(
  //             color: Colors.transparent,
  //             alignment: Alignment.center,
  //             child: const CircularProgressIndicator(),
  //           ),
  //         ),
  //       );
  //       Position locationData = await Geolocator.getCurrentPosition();
  //       // N.back();
  //       Navigator.pop(context);
  //       return LatLng(
  //         locationData.latitude,
  //         locationData.longitude,
  //       );
  //     } else {
  //       // final isGpsEnabled = await Helpers.bottomSheet(
  //       //   context: context,
  //       //   child: const RequestLocationSheet(),
  //       //   backgroundColor: Colors.white,
  //       // );
  //       // if (isGpsEnabled == null) return null;
  //       // showDialog(
  //       //   context: context,
  //       //   builder: (_) => Material(
  //       //     color: Colors.transparent,
  //       //     child: Container(
  //       //       color: Colors.transparent,
  //       //       alignment: Alignment.center,
  //       //       child: const CircularProgressIndicator(),
  //       //     ),
  //       //   ),
  //       // );
  //       try {
  //         Position locationData = await Geolocator.getCurrentPosition();
  //         // N.back();
  //         Navigator.pop(context);
  //         return LatLng(
  //           locationData.latitude,
  //           locationData.longitude,
  //         );
  //       }catch(e){
  //         return null;
  //       }
  //     }
  //   } else
  //     return null;
  // }
  static Future<LatLng?> getCurrentLocation({
    required BuildContext context,
    bool isNewestLocation = false,
  }) async {
    LocationPermission locationPermission = await Geolocator.checkPermission();

    // لو مرفوضة أو مرفوضة للأبد
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();

      // لو لسة مرفوضة
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("مش كدا يا نجم!"),
              content: const Text(
                "من غير صلاحية الوصول للموقع مش هنعرف نكمل. افتح الإعدادات وفعلها.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ماشي"),
                ),
                TextButton(
                  onPressed: () {
                    Geolocator.openAppSettings();
                    Navigator.pop(context);
                  },
                  child: const Text("افتح الإعدادات"),
                ),
              ],
            );
          },
        );
        return null;
      }
    }

    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("شغل الـ GPS"),
              content: const Text("لازم تشغل الـ GPS علشان نحدد موقعك."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("تمام"),
                ),
              ],
            );
          },
        );
        return null;
      }

      // عرض Loader
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        Position locationData = await Geolocator.getCurrentPosition();
        Navigator.pop(context); // لإغلاق الـ loader
        return LatLng(locationData.latitude, locationData.longitude);
      } catch (e) {
        Navigator.pop(context);
        debugPrint("Error getting location: $e");
        return null;
      }
    }

    return null;
  }

  static Future<LatLng?> getCurrentLocationNew({
    // required BuildContext context,
    bool isNewestLocation = false,
  }) async {
    // List<Placemark> newPlace = await placemarkFromCoordinates(AppShared.currentLocation!.latitude, AppShared.currentLocation!.longitude);
    // Placemark placeMark  = newPlace[0];
    // String? name = placeMark.name;
    // String? subLocality = placeMark.subLocality;
    // String? locality = placeMark.locality;
    // String? administrativeArea = placeMark.administrativeArea;
    // String? postalCode = placeMark.postalCode;
    // String? country = placeMark.country;
    // String? street = placeMark.street;
    // print(street);
    // if (!isNewestLocation && AppShared.currentLocation != null)
    //   return AppShared.currentLocation;
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
    }
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      if (Platform.isIOS) {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) => Material(
        //     color: Colors.transparent,
        //     child: Container(
        //       color: Colors.transparent,
        //       alignment: Alignment.center,
        //       child: const CircularProgressIndicator(),
        //     ),
        //   ),
        // );
        Position locationData = await Geolocator.getCurrentPosition();
        // N.back();
        // Navigator.pop(context);
        return  LatLng(
          locationData.latitude,
          locationData.longitude,
        );
      }
      bool isGps = await Geolocator.isLocationServiceEnabled();
      if (isGps) {
        // showDialog(
        //   context: context,
        //   builder: (_) => Material(
        //     color: Colors.transparent,
        //     child: Container(
        //       color: Colors.transparent,
        //       alignment: Alignment.center,
        //       child: const CircularProgressIndicator(),
        //     ),
        //   ),
        // );
        Position locationData = await Geolocator.getCurrentPosition();
        // N.back();
        // Navigator.pop(context);
        return LatLng(
          locationData.latitude,
          locationData.longitude,
        );
      } else {
        // final isGpsEnabled = await Helpers.bottomSheet(
        //   context: context,
        //   child: const RequestLocationSheet(),
        //   backgroundColor: Colors.white,
        // );
        // if (isGpsEnabled == null) return null;
        // showDialog(
        //   context: context,
        //   builder: (_) => Material(
        //     color: Colors.transparent,
        //     child: Container(
        //       color: Colors.transparent,
        //       alignment: Alignment.center,
        //       child: const CircularProgressIndicator(),
        //     ),
        //   ),
        // );
        try {
          Position locationData = await Geolocator.getCurrentPosition();
          // N.back();
          // Navigator.pop(context);
          return LatLng(
            locationData.latitude,
            locationData.longitude,
          );
        }catch(e){
          return null;
        }
      }
    } else
      return null;
  }

}