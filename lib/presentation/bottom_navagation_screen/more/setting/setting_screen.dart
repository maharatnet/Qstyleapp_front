import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:maharat_ecommerce/component/color_manger.dart';
import 'package:maharat_ecommerce/component/component.dart';
import 'package:maharat_ecommerce/component/font_manager.dart';
import 'package:maharat_ecommerce/component/styles_manager.dart';
import 'package:maharat_ecommerce/core/shared_preferefance_value.dart';
import 'package:maharat_ecommerce/core/textApp.dart';
import 'package:maharat_ecommerce/presentation/bottom_nav/bottom_navagiation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLang = 'ar';

  void _selectLang(String lang) {
    setState(() {
      _selectedLang = lang;
      context.setLocale(Locale(lang));
      SharedPreferenceGetValue.saveLanguage(lang);
      navigateAndFinish(context,BottomNavigationScreen());
    });

    // هنا تضيف كود تغيير اللغة حسب التطبيق
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(SharedPreferenceGetValue.getLanguage());
    _selectedLang = SharedPreferenceGetValue.getLanguage();
    refreshData();
  }

  void refreshData(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title:  Text(tr(TextApp.language),style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s18),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildLangButton("العربية", "ar"),
            const SizedBox(height: 16),
            _buildLangButton("English", "en"),
          ],
        ),
      ),
    );
  }

  Widget _buildLangButton(String title, String code) {
    bool isSelected = _selectedLang == code;

    return GestureDetector(
      onTap: () => _selectLang(code),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade50 : Colors.white,
          border: Border.all(color: isSelected ? Colors.black : Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.black : Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
