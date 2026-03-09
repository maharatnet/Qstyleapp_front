
class  AppConstants {

  static const String base_url = "https://theqstyle.com/api/v1/";
  // static const String base_url = "https://theqstyle.com/api/v1/delete-account";
  static const String login = "login";
  static const String register = "register";
  static const String verify_account = "verify-account";
  static const String notifications = "notifications";
  static const String categories = "categories";
  static const String banners = "banners";
  static const String blogs = "blogs";
  static const String products = "products";
  static const String contact_us = "contact-us";
  static const String product_attachments = "product-attachments";
  static const String cart = "cart";
  static const String check_product = "check-product";
  static const String getFavourites = "favourites";
  static const String getAddress = "my-addresses";
  static const String addAddress = "add-address";
  static const String getNotifications = "notifications";
  static const String getSettings = "settings";
  static const String updateProfile = "update-profile";
  static const String orders = "orders";
  static const String checkProduct = "check-product";
  static const String make_notifications_read = "make-notifications-read";
  static const String forgetPassword = "forget-password";
  static const String verifyOtp = "verify-otp";
  static const String resetPassword = "reset-password";
  // static const String orders = "orders";
  // static const String updateAddress = "edit-address";
  static  String categoriesProduct(int id) => "category-products/$id";
  static  String productsDetails(int id) => "products/$id";
  static  String saveFavourite(int id) => "favourites/$id";
  static  String updateCart(int id) => "cart/$id";
  static  String updateAddress(int id) => "edit-address/$id";
  static  String deleteAddress(int id) => "delete-address/$id";
  static  String deleteCart(int id) => "cart/$id";



}