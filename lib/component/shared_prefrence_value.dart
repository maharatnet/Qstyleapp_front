// import 'package:easy_localization/easy_localization.dart';
// import 'package:gold_market/network/cache_helper.dart';
// // import 'package:legal_system/network/cache_helper.dart';
//
// class SharedPreferenceValue {
//
//   static void saveToken(String token) {
//     CacheHelper.saveData(key: "TokenEducation", value: token);
//   }
//   static String getToken() {
//     return CacheHelper.getData(key: "TokenEducation") == null ? "" : CacheHelper.getData(key: "TokenEducation");
//   }
//   static void saveLogin(String email) {
//     CacheHelper.saveData(key: "LoginModel", value: email);
//   }
//   static String getLogin() {
//     return CacheHelper.getData(key: "LoginModel") == null ? "" : CacheHelper.getData(key: "LoginModel");
//   }
//
//   static void savePassword(String password) {
//     CacheHelper.saveData(key: "Password", value: password);
//   }
//
//   static String getPassword() {
//     return CacheHelper.getData(key: "Password") == null ? "" : CacheHelper.getData(key: "Password");
//   }
//   static void saveRememberMe(bool remember) {
//     CacheHelper.saveData(key: "RememberMe", value: remember);
//   }
//
//   static bool getRememberMe() {
//     return CacheHelper.getData(key: "RememberMe") == null ? false : CacheHelper.getData(key: "RememberMe");
//   }
//   static void saveCountScan(int count) {
//     CacheHelper.saveData(key: "CountScan", value: count);
//   }
//
//   static int getCountScan() {
//     return CacheHelper.getData(key: "CountScan") == null ? 0 : CacheHelper.getData(key: "CountScan");
//   }
//
// }