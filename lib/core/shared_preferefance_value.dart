import 'package:maharat_ecommerce/network/cache_helper.dart';

class SharedPreferenceGetValue {
  static String token  ="";

  static void saveUser(String token) {
    CacheHelper.saveData(key: "ProfileUser", value: token);
  }
  static void saveToken(String token) {
    CacheHelper.saveData(key: "tokenUser", value: token);
  }
  static String getToken() {
    return  CacheHelper.getData(key: "tokenUser")==null?"":CacheHelper.getData(key: "tokenUser");
  }
  static String getUser() {
    return  CacheHelper.getData(key: "ProfileUser")==null?"":CacheHelper.getData(key: "ProfileUser");
  }
  static void saveOnBoarding(bool value) {
    CacheHelper.saveData(key: "onBoardingUser", value:value);
  }
  static bool getOnBoarding() {
    return  CacheHelper.getData(key: "onBoardingUser")==null?false:CacheHelper.getData(key: "onBoardingUser");
  }
  // static String getCountry() {
  //   return  CacheHelper.getData(key: "CountryUser")==null?"EG":CacheHelper.getData(key: "CountryUser");
  // }
  // static void saveCountry(String token) {
  //   CacheHelper.saveData(key: "CountryUser", value: token);
  // }
  static String getCountryID() {
    return  CacheHelper.getData(key: "CountryUserID")==null?"21ed5e5f-4dbd-448f-a6b8-4164ebd9f53e":CacheHelper.getData(key: "CountryUserID");
  }
  static void saveCountryID(String token) {
    CacheHelper.saveData(key: "CountryUserID", value: token);
  }

  static void saveNameProfile(String token) {
    CacheHelper.saveData(key: "NameProfile", value: token);
  }

  static String getNameProfile() {
    return CacheHelper.getData(key: "NameProfile") == null ? "" : CacheHelper.getData(
        key: "NameProfile");
  }
  static void saveDataId(String id) {
    CacheHelper.saveData(key: "DataId", value: id);
  }

  static String getDataId() {
    return CacheHelper.getData(key: "DataId") == null ? "0" : CacheHelper.getData(
        key: "DataId");
  }

  static void saveIsHod(int id) {
    CacheHelper.saveData(key: "IsHod", value: id);
  }

  static int getIsHod() {
    return CacheHelper.getData(key: "IsHod") == null ? 0 : CacheHelper.getData(
        key: "IsHod");
  }
  static void saveIsEmployee(int id) {
    CacheHelper.saveData(key: "IsEmployee", value: id);
  }

  static int getIsEmployee() {
    return CacheHelper.getData(key: "IsEmployee") == null ? 0 : CacheHelper.getData(
        key: "IsEmployee");
  }


}