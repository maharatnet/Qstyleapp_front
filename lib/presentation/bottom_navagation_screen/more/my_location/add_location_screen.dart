// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:maharat_ecommerce/component/color_manger.dart';
// import 'package:maharat_ecommerce/component/custom_button.dart';
// import 'package:maharat_ecommerce/core/app_toast/app_toast.dart';
// import 'package:maharat_ecommerce/core/textApp.dart';
// import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/edit_profile_screen/edit_profile_screen.dart';
// import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/cubit/location_cubit.dart';
//
// import '../../../../../../component/dimensions.dart';
// import '../../../../../../component/font_manager.dart';
// import '../../../../../../component/styles_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class AddLocationMapScreen extends StatefulWidget {
//   final double lat;
//   final double lng;
//   final bool isEdit;
//   final int addressId;
//
//   const AddLocationMapScreen({
//     super.key,
//     this.lat = 0.0,
//     this.lng = 0.0,
//     this.isEdit = false,
//     this.addressId = 0,
//   });
//
//   @override
//   State<AddLocationMapScreen> createState() => _AddLocationMapScreenState();
// }
//
// class _AddLocationMapScreenState extends State<AddLocationMapScreen>
//     with WidgetsBindingObserver {
//   bool _isSearchExpanded = false;
//   final FocusNode _searchFocusNode = FocusNode();
//   GoogleMapController? _mapController;
//   bool _isMapReady = false;
//   bool _isControllerReady = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _searchFocusNode.addListener(() {
//       setState(() {
//         _isSearchExpanded = _searchFocusNode.hasFocus;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _searchFocusNode.dispose();
//     _mapController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.resumed) {
//       // Reset controller ready flag to handle potential channel issues
//       _isControllerReady = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LocationCubit, LocationStates>(
//       listener: (context, state) {
//         _handleStateChanges(context, state);
//       },
//       builder: (context, state) {
//         final cubit = LocationCubit.get(context);
//
//         if (cubit.latLng == null) {
//           return Scaffold(
//             appBar: _buildAppBar(context),
//             body: MapScreenShimmer(),
//           );
//         }
//
//         return Scaffold(
//           appBar: _buildAppBar(context),
//           body: Stack(
//             children: [
//               // الخريطة
//               _buildMap(cubit, context),
//
//               // شريط البحث
//               _buildSearchBar(cubit, state, context),
//
//               // نتائج البحث
//               if (_shouldShowSearchResults(cubit, state))
//                 _buildSearchResults(cubit, context),
//
//               // معلومات الموقع والأزرار
//               _buildBottomSheet(cubit, state, context),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // بناء AppBar
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       title: Text(
//         widget.isEdit ? tr(TextApp.edit_location) : tr(TextApp.add_location),
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       centerTitle: true,
//       elevation: 0,
//       actions: [
//         IconButton(
//           icon: Icon(Icons.my_location),
//           onPressed: () => _moveToCurrentLocation(context),
//           tooltip: tr(TextApp.current_location),
//         ),
//       ],
//     );
//   }
//
//   // بناء الخريطة - مع معالجة أفضل للأخطاء
//   Widget _buildMap(LocationCubit cubit, BuildContext context) {
//     return GoogleMap(
//       mapType: MapType.normal,
//       markers: _getSafeMarkers(cubit),
//       zoomControlsEnabled: true,
//       myLocationButtonEnabled: false,
//       myLocationEnabled: true,
//       compassEnabled: false,
//       mapToolbarEnabled: false,
//       onTap: (position) {
//         _onMapTap(cubit, position, context);
//       },
//       initialCameraPosition: _getInitialCameraPosition(cubit),
//       onMapCreated: (GoogleMapController controller) {
//         _onMapCreated(cubit, controller, context);
//       },
//     );
//   }
//
//   // الحصول على Markers بشكل آمن
//   Set<Marker> _getSafeMarkers(LocationCubit cubit) {
//     try {
//       return cubit.markers ?? <Marker>{};
//     } catch (e) {
//       print('Error getting markers: $e');
//       return <Marker>{};
//     }
//   }
//
//   // الحصول على موضع الكاميرا الأولي بشكل آمن
//   CameraPosition _getInitialCameraPosition(LocationCubit cubit) {
//     try {
//       return cubit.initialCameraPosition ??
//           CameraPosition(
//             zoom: 15,
//             target: LatLng(
//               widget.lat != 0.0 ? widget.lat : 24.7136, // الرياض كافتراضي
//               widget.lng != 0.0 ? widget.lng : 46.6753,
//             ),
//           );
//     } catch (e) {
//       print('Error getting initial camera position: $e');
//       return CameraPosition(
//         zoom: 15,
//         target: LatLng(24.7136, 46.6753), // الرياض كافتراضي
//       );
//     }
//   }
//
//   // بناء شريط البحث
//   Widget _buildSearchBar(LocationCubit cubit, LocationStates state, BuildContext context) {
//     return Positioned(
//       top: 16,
//       left: 16,
//       right: 16,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: TextField(
//           controller: cubit.searchController,
//           focusNode: _searchFocusNode,
//           onChanged: (query) {
//             if (query.isNotEmpty) {
//               cubit.searchPlaces(query);
//             } else {
//               cubit.clearSearchResults();
//             }
//           },
//           decoration: InputDecoration(
//             hintText: tr(TextApp.search_location),
//             prefixIcon: Icon(Icons.search, color: ColorManager.primary),
//             suffixIcon: cubit.searchController.text.isNotEmpty
//                 ? IconButton(
//               icon: Icon(Icons.clear, color: Colors.grey),
//               onPressed: () {
//                 cubit.searchController.clear();
//                 cubit.clearSearchResults();
//                 _searchFocusNode.unfocus();
//               },
//             )
//                 : null,
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // بناء نتائج البحث
//   Widget _buildSearchResults(LocationCubit cubit, BuildContext context) {
//     return Positioned(
//       top: 80,
//       left: 16,
//       right: 16,
//       child: Container(
//         constraints: BoxConstraints(maxHeight: 300),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: cubit.isSearching
//             ? _buildSearchLoading()
//             : _buildSearchList(cubit, context),
//       ),
//     );
//   }
//
//   // بناء loading للبحث
//   Widget _buildSearchLoading() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 20,
//             height: 20,
//             child: CircularProgressIndicator(strokeWidth: 2),
//           ),
//           SizedBox(width: 16),
//           Text(tr(TextApp.searching)),
//         ],
//       ),
//     );
//   }
//
//   // بناء قائمة نتائج البحث
//   Widget _buildSearchList(LocationCubit cubit, BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       itemCount: cubit.placePredictions.length,
//       separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey.shade200),
//       itemBuilder: (context, index) {
//         final prediction = cubit.placePredictions[index];
//         return ListTile(
//           leading: Container(
//             padding: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: ColorManager.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(
//               Icons.location_on,
//               color: ColorManager.primary,
//               size: 20,
//             ),
//           ),
//           title: Text(
//             prediction['description'] ?? '',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           onTap: () => _selectSearchResult(cubit, prediction, context),
//         );
//       },
//     );
//   }
//
//   // بناء الجزء السفلي
//   Widget _buildBottomSheet(LocationCubit cubit, LocationStates state, BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // مؤشر السحب
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               //
//               // // عنوان الموقع
//               // Text(
//               //   tr(TextApp.location_name),
//               //   style: getBoldStyle(fontSize: 16, color: Colors.black87),
//               // ),
//               SizedBox(height: 8),
//
//               // حقل اسم الموقع
//               _buildNameField(cubit),
//               SizedBox(height: 16),
//
//               // // العنوان المفصل
//               // Text(
//               //   tr(TextApp.detailed_address),
//               //   style: getBoldStyle(fontSize: 16, color: Colors.black87),
//               // ),
//               SizedBox(height: 8),
//
//               // عرض العنوان
//               _buildAddressDisplay(cubit),
//               SizedBox(height: 20),
//
//               // زر الحفظ
//               _buildSaveButton(cubit, state, context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // بناء حقل الاسم
//   Widget _buildNameField(LocationCubit cubit) {
//     return TextFormField(
//       controller: cubit.titleController,
//       decoration: InputDecoration(
//         hintText: tr(TextApp.additional_address),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: ColorManager.primary, width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         prefixIcon: Icon(Icons.edit, color: ColorManager.primary),
//       ),
//     );
//   }
//
//   // بناء عرض العنوان
//   Widget _buildAddressDisplay(LocationCubit cubit) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.location_on, color: ColorManager.primary, size: 20),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               cubit.fullAddress?.isNotEmpty == true
//                   ? cubit.fullAddress!
//                   : tr(TextApp.tap_map_to_select_location),
//               style: TextStyle(
//                 fontSize: 14,
//                 color: cubit.fullAddress?.isNotEmpty == true
//                     ? Colors.black87
//                     : Colors.grey.shade600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // بناء زر الحفظ
//   Widget _buildSaveButton(LocationCubit cubit, LocationStates state, BuildContext context) {
//     final isLoading = state is LoadingAddLocationDataStates ||
//         state is LoadingUpdateLocationDataStates;
//
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : () => _onSavePressed(cubit, context),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: ColorManager.primary,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 0,
//         ),
//         child: isLoading
//             ? SizedBox(
//           width: 20,
//           height: 20,
//           child: CircularProgressIndicator(
//             color: Colors.white,
//             strokeWidth: 2,
//           ),
//         )
//             : Text(
//           widget.isEdit ? tr(TextApp.update_location) : tr(TextApp.save_location),
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
//
//   // التعامل مع تغييرات الحالة
//   void _handleStateChanges(BuildContext context, LocationStates state) {
//     if (state is SuccessAddLocationDataStates || state is SuccessUpdateLocationDataStates) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             widget.isEdit
//                 ? tr(TextApp.location_updated_successfully)
//                 : tr(TextApp.location_added_successfully),
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pop(context);
//     } else if (state is ErrorAddLocationDataStates || state is ErrorUpdateLocationDataStates) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(tr(TextApp.error_occurred)),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//     }
//   }
//
//   // عند النقر على الخريطة
//   void _onMapTap(LocationCubit cubit, LatLng position, BuildContext context) {
//     try {
//       cubit.onTap(position, context: context);
//       _searchFocusNode.unfocus();
//     } catch (e) {
//       print('Error on map tap: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(tr(TextApp.error_occurred)),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//     }
//   }
//
//   // عند إنشاء الخريطة - مع معالجة محسنة للأخطاء
//   Future<void> _onMapCreated(LocationCubit cubit, GoogleMapController controller, BuildContext context) async {
//     try {
//       _mapController = controller;
//       _isMapReady = true;
//
//       // انتظار قصير للتأكد من استقرار الـ controller
//       await Future.delayed(Duration(milliseconds: 300));
//
//       if (!cubit.controller.isCompleted) {
//         cubit.controller.complete(controller);
//       }
//
//       _isControllerReady = true;
//       cubit.notifyMap();
//
//       final initialPosition = cubit.initialCameraPosition?.target ??
//           LatLng(widget.lat, widget.lng);
//
//       // التأكد من أن الموضع صالح
//       if (initialPosition.latitude != 0.0 || initialPosition.longitude != 0.0) {
//         cubit.onTap(initialPosition, context: context, getFullAddress: true);
//       }
//     } catch (e) {
//       print('Error in onMapCreated: $e');
//       // إعادة المحاولة بعد فترة قصيرة
//       Future.delayed(Duration(seconds: 1), () {
//         if (mounted && !_isControllerReady) {
//           _onMapCreated(cubit, controller, context);
//         }
//       });
//     }
//   }
//
//   // اختيار نتيجة البحث
//   void _selectSearchResult(LocationCubit cubit, Map<String, dynamic> prediction, BuildContext context) {
//     try {
//       cubit.selectPlace(prediction['place_id'], context);
//       cubit.searchController.clear();
//       cubit.clearSearchResults();
//       _searchFocusNode.unfocus();
//     } catch (e) {
//       print('Error selecting search result: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(tr(TextApp.error_occurred)),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//     }
//   }
//
//   // الانتقال للموقع الحالي - مع معالجة محسنة للأخطاء
//   Future<void> _moveToCurrentLocation(BuildContext context) async {
//     if (!_isMapReady || !_isControllerReady) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(tr(TextApp.map_not_ready)),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//       return;
//     }
//
//     final cubit = LocationCubit.get(context);
//
//     try {
//       final position = await cubit.getCurrentLocation(context: context);
//       if (position != null) {
//         final currentLocation = LatLng(position.latitude, position.longitude);
//         cubit.onTap(currentLocation, context: context);
//
//         // انتظار قصير قبل تحريك الكاميرا
//         await Future.delayed(Duration(milliseconds: 100));
//         await _safeAnimateToPosition(cubit, currentLocation);
//       }
//     } catch (e) {
//       print('Error getting current location: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(tr(TextApp.failed_to_get_current_location)),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//     }
//   }
//
//   // تحريك الكاميرا بشكل آمن
//   Future<void> _safeAnimateToPosition(LocationCubit cubit, LatLng position) async {
//     if (!_isControllerReady || _mapController == null) {
//       print('Controller not ready for animation');
//       return;
//     }
//
//     try {
//       await _mapController!.animateCamera(
//         CameraUpdate.newLatLngZoom(position, 16.0),
//       );
//     } on PlatformException catch (e) {
//       print('Platform exception during camera animation: $e');
//       if (e.code == 'channel-error') {
//         // إعادة المحاولة بعد فترة قصيرة
//         await Future.delayed(Duration(milliseconds: 500));
//         try {
//           await _mapController!.animateCamera(
//             CameraUpdate.newLatLngZoom(position, 16.0),
//           );
//         } catch (retryError) {
//           print('Retry animation failed: $retryError');
//         }
//       }
//     } catch (e) {
//       print('Error animating camera: $e');
//     }
//   }
//
//   // عند الضغط على زر الحفظ
//   void _onSavePressed(LocationCubit cubit, BuildContext context) {
//     final validation = _validateForm(cubit);
//
//     if (validation.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(validation),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//       return;
//     }
//
//     try {
//       final locationData = {
//         "name": cubit.titleController.text.trim(),
//         "description": cubit.fullAddress ?? "",
//         "longitude": cubit.latLng!.longitude,
//         "latitude": cubit.latLng!.latitude,
//         "is_default": widget.isEdit ? 0 : 1,
//       };
//
//       if (widget.isEdit) {
//         cubit.updateLocation(context, locationData, widget.addressId);
//       } else {
//         cubit.addLocation(context, locationData);
//       }
//     } catch (e) {
//       print('Error saving location: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(tr(TextApp.error_occurred)),
//           backgroundColor: ColorManager.error,
//         ),
//       );
//     }
//   }
//
//   // التحقق من صحة النموذج
//   String _validateForm(LocationCubit cubit) {
//     if (cubit.titleController.text.trim().isEmpty) {
//       return tr(TextApp.please_enter_location_name);
//     }
//
//     if (cubit.latLng == null) {
//       return tr(TextApp.please_select_location_on_map);
//     }
//
//     if (cubit.fullAddress?.isEmpty ?? true) {
//       return tr(TextApp.please_wait_for_address_loading);
//     }
//
//     return "";
//   }
//
//   // تحديد ما إذا كانت نتائج البحث يجب أن تظهر
//   bool _shouldShowSearchResults(LocationCubit cubit, LocationStates state) {
//     return (_isSearchExpanded || cubit.searchController.text.isNotEmpty) &&
//         (cubit.placePredictions.isNotEmpty || state is LoadingSearchPlacesState);
//   }
// }
// class MapScreenShimmer extends StatelessWidget {
//   const MapScreenShimmer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Stack(
//         children: [
//           // Fake map background
//           Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               color: Colors.grey[300],
//             ),
//           ),
//
//           // Bottom Positioned Shimmer for Fields & Button
//           Positioned(
//             bottom: 40,
//             left: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 // Shimmer TextField
//                 ShimmerBox(height: 50, width: double.infinity, borderRadius: 12),
//
//                 const SizedBox(height: 10),
//
//                 // Shimmer for address container
//                 ShimmerBox(height: 50, width: double.infinity, borderRadius: 12),
//
//                 const SizedBox(height: 10),
//
//                 // Shimmer for submit button
//                 ShimmerBox(height: 48, width: double.infinity, borderRadius: 12),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ShimmerBox extends StatelessWidget {
//   final double height;
//   final double width;
//   final double borderRadius;
//
//   const ShimmerBox({
//     super.key,
//     required this.height,
//     required this.width,
//     this.borderRadius = 8.0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: Colors.grey[300],
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/model/app_setting_response.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
import 'package:maharat_ecommerce/presentation/bottom_navagation_screen/more/my_location/cubit/location_cubit.dart';

class AddLocationMapScreen extends StatefulWidget {
  final bool isEdit;
  final int addressId;
  final String? existingCountryName;
  final int? existingCountryId;
  final String? existingCity;
  final String? existingDescription;

  const AddLocationMapScreen({
    super.key,
    this.isEdit = false,
    this.addressId = 0,
    this.existingCountryName,
    this.existingCity,
    this.existingCountryId,
    this.existingDescription,
  });

  @override
  State<AddLocationMapScreen> createState() => _AddLocationMapScreenState();
}

class _AddLocationMapScreenState extends State<AddLocationMapScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CountriesModel? _selectedCountry;
  List<CountriesModel> _countries = [];
  bool _isLoadingCountries = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _initializeEditData();
  }

  void _initializeEditData() {
    if (widget.isEdit) {
      _cityController.text = widget.existingCity ?? '';
      _descriptionController.text = widget.existingDescription ?? '';
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    setState(() {
      _isLoadingCountries = true;
    });

    try {
      _countries = BottomNavigationCubit.get(context).countryList;
      final cubit = LocationCubit.get(context);
      // افتراض أن هناك method في الcubit لجلب الدول
      // await cubit.getCountries();

      setState(() {
        // _countries = cubit.countries ?? [];
        _isLoadingCountries = false;

        // إذا كنا في وضع التعديل، ابحث عن الدولة المحددة مسبقاً
        if (widget.isEdit && widget.existingCountryName != null) {
          _selectedCountry = _countries.firstWhere(
                (country) => country.id == widget.existingCountryId,
            orElse: () => _countries.isNotEmpty ? _countries.first : CountriesModel(),
          );
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingCountries = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(
        // SnackBar(
          // content: Text(tr(TextApp.error_loading_countries)),
          // backgroundColor: ColorManager.error,
        // ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
        _handleStateChanges(context, state);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _isLoadingCountries
              ? _buildLoadingWidget()
              : _buildForm(state),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        widget.isEdit ? tr(TextApp.edit_location) : tr(TextApp.add_location),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ColorManager.primary),
          SizedBox(height: 16),
          // Text(
          //   tr(TextApp.loading_countries),
          //   style: TextStyle(
          //     fontSize: 16,
          //     color: Colors.grey.shade600,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildForm(LocationStates state) {
    final isSubmitting = state is LoadingAddLocationDataStates ||
        state is LoadingUpdateLocationDataStates;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Country Dropdown
            _buildCountryDropdown(),
            SizedBox(height: 20),

            // City Field
            _buildCityField(),
            SizedBox(height: 20),

            // Description Field
            _buildDescriptionField(),
            SizedBox(height: 40),

            // Save Button
            _buildSaveButton(isSubmitting),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(TextApp.country),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CountriesModel>(
              value: _selectedCountry,
              hint: Text(
                tr(TextApp.select_country),
                style: TextStyle(color: Colors.grey.shade600),
              ),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.primary),
              items: _countries.map((CountriesModel country) {
                return DropdownMenuItem<CountriesModel>(
                  value: country,
                  child: Text(
                    country.name ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (CountriesModel? newValue) {
                setState(() {
                  _selectedCountry = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(TextApp.city),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _cityController,
          decoration: InputDecoration(
            hintText: tr(TextApp.enter_city_name),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorManager.primary, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefixIcon: Icon(Icons.location_city, color: ColorManager.primary),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return tr(TextApp.please_enter_city_name);
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(TextApp.description),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: tr(TextApp.enter_address_description),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorManager.primary, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            prefixIcon: Icon(Icons.description, color: ColorManager.primary),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return tr(TextApp.please_enter_description);
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(bool isSubmitting) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isSubmitting ? null : _onSavePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isSubmitting
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          widget.isEdit ? tr(TextApp.update_location) : tr(TextApp.save_location),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _onSavePressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr(TextApp.please_select_country)),
          backgroundColor: ColorManager.error,
        ),
      );
      return;
    }

    try {
      final cubit = LocationCubit.get(context);

      final locationData = {
        "country_id": _selectedCountry!.id,
        // "country_name": _selectedCountry!.name,
        "city": _cityController.text.trim(),
        "description": _descriptionController.text.trim(),
        // "shipping_fees": _selectedCountry!.shippingFees,
        // "is_default": widget.isEdit ? 0 : 1,
      };

      if (widget.isEdit) {
        cubit.updateLocation(context, locationData, widget.addressId);
      } else {
        cubit.addLocation(context, locationData);
      }
    } catch (e) {
      print('Error saving location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr(TextApp.error_occurred)),
          backgroundColor: ColorManager.error,
        ),
      );
    }
  }

  void _handleStateChanges(BuildContext context, LocationStates state) {
    if (state is SuccessAddLocationDataStates || state is SuccessUpdateLocationDataStates) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEdit
                ? tr(TextApp.location_updated_successfully)
                : tr(TextApp.location_added_successfully),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (state is ErrorAddLocationDataStates || state is ErrorUpdateLocationDataStates) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr(TextApp.error_occurred)),
          backgroundColor: ColorManager.error,
        ),
      );
    }
  }
}
