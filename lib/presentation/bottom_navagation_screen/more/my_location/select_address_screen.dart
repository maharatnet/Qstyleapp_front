import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class SelectAddressScreen extends StatelessWidget {
  AddressModel? addressModel;
  Function (AddressModel? value) function;
  SelectAddressScreen({this.addressModel, required this.function});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>LocationCubit()..getLocationApi(context),
      child: BlocConsumer<LocationCubit,LocationStates>(
        listener: (context,state){},
        builder: (context,state){
          final cubit = LocationCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                tr(TextApp.location),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              centerTitle: true,
              // backgroundColor: Colors.blue,
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Placeholder for current location or any map-related widgets
                  // Container(
                  //   height: 250,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade200,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Center(
                  //     child: Icon(Icons.location_on, size: 100, color: Colors.blue),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // List of saved locations (can be dynamic)
                  Expanded(
                    child: cubit.is_get_location ||
                        state is LoadingLocationDataStates
                        ? ListView.builder(
                        itemCount: 5, // Example item count
                        itemBuilder: (context, index) =>buildLocationShimmerCard()):
                    cubit.addressResponseModel == null ||
                        cubit.addressResponseModel!.data == null ||
                        cubit.addressResponseModel!.data!.length == 0
                        ? EmptyComponent(title: tr(TextApp.no_data))
                        : ListView.builder(
                      itemCount: cubit.addressResponseModel!.data!.length, // Example item count
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4, // Add a shadow for depth
                          shadowColor: Colors.black.withOpacity(0.1),
                          child: GestureDetector(
                            onTap: (){
                              addressModel =cubit.addressResponseModel!.data![index];
                              function(cubit.addressResponseModel!.data![index]);
                              cubit.notifyMap();
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:addressModel!=null&& cubit.addressResponseModel!.data![index].id==addressModel!.id?ColorManager.primary.withOpacity(.1):Colors.white,
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
                                  Icon(Icons.location_on, color: ColorManager.primary, size: 28),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   cubit.addressResponseModel!.data![index].name??"",
                                        //   style: getBoldStyle(
                                        //     fontSize: 14,
                                        //     // fontWeight: FontWeight.bold,
                                        //     color: Colors.black87,
                                        //   ),
                                        // ),
                                        // SizedBox(height: 2),
                                        // Text(
                                        //   cubit.addressResponseModel!.data![index].description??"",
                                        //   // tr(TextApp.addressDetailsGoHere),
                                        //   style: getBoldStyle(
                                        //     fontSize: 12,
                                        //     color: Colors.black54,
                                        //   ),
                                        // ),
                                        Text(
                                          cubit.addressResponseModel!.data![index].country?.name ?? tr(TextApp.unnamed_location),
                                          style: getBoldStyle(fontSize: 14, color: Colors.black87),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          cubit.addressResponseModel!.data![index].city ?? tr(TextApp.unnamed_location),
                                          style: getBoldStyle(fontSize: 14, color: Colors.black87),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          cubit.addressResponseModel!.data![index].description ?? tr(TextApp.no_description),
                                          style: getRegularStyle(fontSize: 12, color: Colors.black54),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // زر التعديل
                                  IconButton(
                                    icon: Icon(Icons.edit, color: ColorManager.primary),
                                    onPressed: () {
                                      // cubit.titleController.text = cubit.addressResponseModel!.data![index].name??"";
                                      // cubit.fullAddress= cubit.addressResponseModel!.data![index].description??"";
                                      // cubit.latLng =LatLng(double.parse(cubit.addressResponseModel!.data![index].latitude??"0.0"),
                                      //     double.parse(cubit.addressResponseModel!.data![index].longitude??"0.0"));
                                      // cubit.onTap(LatLng(double.parse(cubit.addressResponseModel!.data![index].latitude??"0.0"),
                                      //     double.parse(cubit.addressResponseModel!.data![index].longitude??"0.0")), context: context);
                                      navigateTo(context, BlocProvider.value(value:
                                      LocationCubit.get(context),child:
                                      AddLocationMapScreen(isEdit: true,addressId:cubit.addressResponseModel!.data![index].id??1 ,
                                        existingCountryName:cubit.addressResponseModel!.data![index].country?.name! ,
                                        existingCountryId:cubit.addressResponseModel!.data![index].country?.id! ,
                                        existingCity:cubit.addressResponseModel!.data![index].city,
                                        existingDescription:cubit.addressResponseModel!.data![index].description,

                                      ) ));

                                    },
                                  ),
                                  // زر الحذف
                                  IconButton(
                                    icon:cubit.selectIndex==cubit.addressResponseModel!.data![index].id&&state is LoadingDeleteLocationDataStates?CircularProgressIndicator(): Icon(Icons.delete, color: ColorManager.error),
                                    onPressed: () {
                                      cubit.deleteLocation(context, cubit.addressResponseModel!.data![index].id??1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // cubit.getCurrentLocation(context: context);
                navigateTo(context, BlocProvider.value(value: LocationCubit.get(context),child:AddLocationMapScreen(isEdit: false,) ,)
                );
                // إضافة وظيفة لإضافة موقع جديد
              },
              child: Icon(Icons.add,color: ColorManager.white,),
              backgroundColor:ColorManager.primary,
            ),
          );
        },
      ),
    );
  }
}
