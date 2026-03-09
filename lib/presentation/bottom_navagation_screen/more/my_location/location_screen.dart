import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/empty_component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';

import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/address/address_response_model.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/add_location_screen.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/cubit/location_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/widget/build_location_shimmer.dart';

// class MyLocationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create: (_)=>LocationCubit()..getLocationApi(context),
//     child: BlocConsumer<LocationCubit,LocationStates>(
//         listener: (context,state){},
//      builder: (context,state){
//           final cubit = LocationCubit.get(context);
//           return Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 tr(TextApp.location),
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               centerTitle: true,
//               // backgroundColor: Colors.blue,
//             ),
//             body: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // Placeholder for current location or any map-related widgets
//                   // Container(
//                   //   height: 250,
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.grey.shade200,
//                   //     borderRadius: BorderRadius.circular(12),
//                   //   ),
//                   //   child: Center(
//                   //     child: Icon(Icons.location_on, size: 100, color: Colors.blue),
//                   //   ),
//                   // ),
//                   // SizedBox(height: 20),
//                   // List of saved locations (can be dynamic)
//                   Expanded(
//                     child: cubit.is_get_location ||
//               state is LoadingLocationDataStates
//               ? ListView.builder(
//     itemCount: 5, // Example item count
//     itemBuilder: (context, index) =>buildLocationShimmerCard()):
//                     cubit.addressResponseModel == null ||
//                 cubit.addressResponseModel!.data == null ||
//             cubit.addressResponseModel!.data!.length == 0
//             ? EmptyComponent(title: tr(TextApp.no_data))
//            : ListView.builder(
//                       itemCount: cubit.addressResponseModel!.data!.length, // Example item count
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: EdgeInsets.only(bottom: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 4, // Add a shadow for depth
//                           shadowColor: Colors.black.withOpacity(0.1),
//                           child: Container(
//                             padding: EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.shade300,
//                                   blurRadius: 8,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.location_on, color: ColorManager.primary, size: 28),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         cubit.addressResponseModel!.data![index].name??"",
//                                         style: getBoldStyle(
//                                           fontSize: 14,
//                                           // fontWeight: FontWeight.bold,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                       SizedBox(height: 2),
//                                       Text(
//                                         cubit.addressResponseModel!.data![index].description??"",
//                                         // tr(TextApp.addressDetailsGoHere),
//                                         style: getBoldStyle(
//                                           fontSize: 12,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 // زر التعديل
//                                 IconButton(
//                                   icon: Icon(Icons.edit, color: ColorManager.primary),
//                                   onPressed: () {
//                                     cubit.titleController.text = cubit.addressResponseModel!.data![index].name??"";
//                                     cubit.fullAddress= cubit.addressResponseModel!.data![index].description??"";
//                                     cubit.latLng =LatLng(double.parse(cubit.addressResponseModel!.data![index].latitude??"0.0"),
//                                         double.parse(cubit.addressResponseModel!.data![index].longitude??"0.0"));
//                                     cubit.onTap(LatLng(double.parse(cubit.addressResponseModel!.data![index].latitude??"0.0"),
//                                         double.parse(cubit.addressResponseModel!.data![index].longitude??"0.0")), context: context);
//                                     navigateTo(context, BlocProvider.value(value:
//                                     LocationCubit.get(context),child:
//                                     AddLocationMapScreen(is_edit: true,addressId:cubit.addressResponseModel!.data![index].id??1 ,) ));
//
//                                     },
//                                 ),
//                                 // زر الحذف
//                                 IconButton(
//                                   icon:cubit.selectIndex==cubit.addressResponseModel!.data![index].id&&state is LoadingDeleteLocationDataStates?CircularProgressIndicator(): Icon(Icons.delete, color: ColorManager.error),
//                                   onPressed: () {
//                                     cubit.deleteLocation(context, cubit.addressResponseModel!.data![index].id??1);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   cubit.onTap(LatLng(24.3311029,51.3054177), context: context);
//                   // cubit.getCurrentLocation(context: context,);
//                   navigateTo(context, BlocProvider.value(value: LocationCubit.get(context),child:AddLocationMapScreen(is_edit: false,) ,)
//                   );
//                   // إضافة وظيفة لإضافة موقع جديد
//                 },
//                 child: Icon(Icons.add,color: ColorManager.white,),
//                 backgroundColor:ColorManager.primary,
//               ),
//           );
//      },
//     ),
//     );
//   }
// }

class MyLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit()..getLocationApi(context),
      child: BlocConsumer<LocationCubit, LocationStates>(
        listener: (context, state) {
          // إضافة listeners للحالات المختلفة
          if (state is ErrorLocationDataStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr(TextApp.error_occurred)),
                backgroundColor: ColorManager.error,
              ),
            );
          }
          if (state is SuccessDeleteLocationDataStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr(TextApp.deleted_successfully)),
                backgroundColor: ColorManager.primary,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = LocationCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                tr(TextApp.location),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              actions: [
                // زر refresh
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () => cubit.getLocationApi(context),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await cubit.getLocationApi(context);
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // إضافة current location card
                    // _buildCurrentLocationCard(cubit, context),
                    SizedBox(height: 16),

                    // قائمة المواقع المحفوظة
                    Expanded(
                      child: _buildLocationsList(cubit, state, context),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _onAddLocationPressed(cubit, context),
              child: Icon(Icons.add, color: ColorManager.white),
              backgroundColor: ColorManager.primary,
            ),
          );
        },
      ),
    );
  }

  // بناء card للموقع الحالي
  Widget _buildCurrentLocationCard(LocationCubit cubit, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [ColorManager.primary.withOpacity(0.1), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.my_location, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(TextApp.current_location),
                    style: getBoldStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    tr(TextApp.tap_to_use_current_location),
                    style: getRegularStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   icon: Icon(Icons.gps_fixed, color: ColorManager.primary),
            //   onPressed: () => _getCurrentLocationAndNavigate(cubit, context),
            // ),
          ],
        ),
      ),
    );
  }

  // بناء قائمة المواقع
  Widget _buildLocationsList(LocationCubit cubit, LocationStates state, BuildContext context) {
    if (cubit.is_get_location || state is LoadingLocationDataStates) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => buildLocationShimmerCard(),
      );
    }

    if (cubit.addressResponseModel == null ||
        cubit.addressResponseModel!.data == null ||
        cubit.addressResponseModel!.data!.isEmpty) {
      return EmptyComponent(
        title: tr(TextApp.no_saved_locations),
        // subtitle: tr(TextApp.add_location_to_get_started),
        // icon: Icons.location_off,
      );
    }

    return ListView.builder(
      itemCount: cubit.addressResponseModel!.data!.length,
      itemBuilder: (context, index) {
        final location = cubit.addressResponseModel!.data![index];
        return _buildLocationCard(cubit, location, state, context, index);
      },
    );
  }

  // بناء card للموقع المحفوظ
  Widget _buildLocationCard(
      LocationCubit cubit,
      AddressModel location, // استبدل بالنوع الصحيح
      LocationStates state,
      BuildContext context,
      int index,
      ) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // أيقونة الموقع
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ColorManager.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.location_on,
                color: ColorManager.primary,
                size: 24,
              ),
            ),
            SizedBox(width: 12),

            // بيانات الموقع
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location?.country?.name ?? tr(TextApp.unnamed_location),
                    style: getBoldStyle(fontSize: 14, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    location?.city ?? tr(TextApp.unnamed_location),
                    style: getBoldStyle(fontSize: 14, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    location.description ?? tr(TextApp.no_description),
                    style: getRegularStyle(fontSize: 12, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // أزرار العمليات
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // زر التعديل
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: ColorManager.primary),
                  onPressed: () => _onEditLocation(cubit, location, context),
                  tooltip: tr(TextApp.edit),
                ),

                // زر الحذف
                IconButton(
                  icon: cubit.selectIndex == location.id &&
                      state is LoadingDeleteLocationDataStates
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Icon(Icons.delete_outline, color: ColorManager.error),
                  onPressed: cubit.selectIndex == location.id &&
                      state is LoadingDeleteLocationDataStates
                      ? null
                      : () => _showDeleteConfirmation(cubit, location, context),
                  tooltip: tr(TextApp.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // // الحصول على الموقع الحالي والانتقال
  // void _getCurrentLocationAndNavigate(LocationCubit cubit, BuildContext context) async {
  //   try {
  //     // إظهار loading
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(
  //         child: Card(
  //           child: Padding(
  //             padding: EdgeInsets.all(20),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 CircularProgressIndicator(),
  //                 SizedBox(height: 16),
  //                 Text(tr(TextApp.getting_current_location)),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //
  //     // الحصول على الموقع الحالي
  //     Position? position = await cubit.getCurrentLocation(context: context);
  //
  //     // إخفاء loading
  //     Navigator.pop(context);
  //
  //     if (position != null) {
  //       LatLng currentLocation = LatLng(position.latitude, position.longitude);
  //       cubit.onTap(currentLocation, context: context);
  //
  //       navigateTo(
  //         context,
  //         BlocProvider.value(
  //           value: LocationCubit.get(context),
  //           child: AddLocationMapScreen(isEdit: false),
  //         ),
  //       );
  //     } else {
  //       _showLocationError(context);
  //     }
  //   } catch (e) {
  //     Navigator.pop(context); // إخفاء loading في حالة الخطأ
  //     _showLocationError(context);
  //   }
  // }

  // عند الضغط على إضافة موقع جديد
  void _onAddLocationPressed(LocationCubit cubit, BuildContext context) async {
    // محاولة الحصول على الموقع الحالي أولاً
    try {
      // Position? position = await cubit.getCurrentLocation(context: context);
      // LatLng defaultLocation = position != null
      //     ? LatLng(position.latitude, position.longitude)
      //     : LatLng(24.3311029, 51.3054177); // موقع افتراضي
      //
      // cubit.onTap(defaultLocation, context: context);

      navigateTo(
        context,
        BlocProvider.value(
          value: LocationCubit.get(context),
          child: AddLocationMapScreen(isEdit: false,),
        ),
      );
    } catch (e) {
      // في حالة فشل الحصول على الموقع، استخدم الموقع الافتراضي
      // cubit.onTap(LatLng(24.3311029, 51.3054177), context: context);

      navigateTo(
        context,
        BlocProvider.value(
          value: LocationCubit.get(context),
          child: AddLocationMapScreen(isEdit: false),
        ),
      );
    }
  }

  // عند تعديل موقع
  void _onEditLocation(LocationCubit cubit, AddressModel location, BuildContext context) {
    // cubit.titleController.text = location.name ?? "";
    // cubit.fullAddress = location.description ?? "";

    // double lat = double.tryParse(location.latitude ?? "0.0") ?? 0.0;
    // double lng = double.tryParse(location.longitude ?? "0.0") ?? 0.0;

    // cubit.latLng = LatLng(lat, lng);
    // cubit.onTap(LatLng(lat, lng), context: context);
// print(location.toJson());
// print(location.toJson());
    navigateTo(
      context,
      BlocProvider.value(
        value: LocationCubit.get(context),
        child: AddLocationMapScreen(
          isEdit: true,
          addressId: location.id ?? 1,
          existingCountryName:location.country?.name! ,
          existingCountryId:location.country?.id! ,
          existingCity:location.city,
          existingDescription:location.description,
        ),
      ),
    );
  }

  // إظهار تأكيد الحذف
  void _showDeleteConfirmation(LocationCubit cubit, dynamic location, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(TextApp.delete_location)),
        content: Text(tr(TextApp.delete_location_confirmation)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr(TextApp.cancel)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteLocation(context, location.id ?? 1);
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: Text(tr(TextApp.delete)),
          ),
        ],
      ),
    );
  }

  // إظهار خطأ الموقع
  void _showLocationError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(TextApp.location_error)),
        backgroundColor: ColorManager.error,
        action: SnackBarAction(
          label: tr(TextApp.settings),
          textColor: Colors.white,
          onPressed: () {
            // فتح إعدادات التطبيق
            Geolocator.openAppSettings();
          },
        ),
      ),
    );
  }
}