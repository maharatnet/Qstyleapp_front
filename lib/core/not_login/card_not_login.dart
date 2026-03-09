import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/loading_image/image_component.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/auth/sign_in/sign_in_screen.dart';
class CardNotLoginScreen extends StatelessWidget {
  const CardNotLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                ColorManager.secondColor.withOpacity(0.1),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Icon / Image
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorManager.secondColor.withOpacity(0.1),
                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: ColorManager.secondColor,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        navigateTo(context, SignInScreen());
                      },
                      child: Text(
                        tr(TextApp.PleaseSignInCreateAnAccount),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 2),

              // ✅ Title
              GestureDetector(
                onTap: (){
                  navigateTo(context, SignInScreen());
                },
                child: Text(
                  tr(TextApp.login),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.black,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


class CardLoginScreen extends StatelessWidget {
  const CardLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                ColorManager.secondColor.withOpacity(0.1),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Icon / Image
              Row(
                children: [
                  if(SharedPreferenceGetValue.getImageProfile().isNotEmpty)
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageComponent(path: SharedPreferenceGetValue.getImageProfile()??"",
                      width: 50,
                        height: 50,
                      )),
                  if(SharedPreferenceGetValue.getImageProfile().isEmpty)
                    CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorManager.secondColor.withOpacity(0.1),
                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: ColorManager.secondColor,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    SharedPreferenceGetValue.getNameProfile(),
                    // tr(TextApp.PleaseSignInCreateAnAccount),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 2),




            ],
          ),
        ),
      ),
    );
  }
}
