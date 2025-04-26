
class  AppConstants {

  static const String base_url = "https://cedemapp.com/new/api/v1/";
  static const String login = "login";
  static const String banners = "banners";
  static const String favourites = "favourites";
  static const String notifications = "notifications";
  static const String categories = "categories";
  static const String blogs = "blogs";
  static const String products = "products";
  static const String contact_us = "contact-us";
  static const String product_attachments = "product-attachments";
  static  String subcategories(int id) => "categories/$id/sub";
  static  String productsDetails(int id) => "products/$id";
  static  String saveFavourite(int id) => "favourites/$id";



}