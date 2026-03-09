import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navigation_cubit.dart';
class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(TextApp.termsConditions))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          BottomNavigationCubit.get(context).appSettingsResponse!.data!.terms??"",

          // "هنا تحط الشروط والأحكام كاملة...",
          style: getRegularStyle(color: Colors.black, fontSize: FontSize.s16),
        ),
      ),
    );
  }
}
