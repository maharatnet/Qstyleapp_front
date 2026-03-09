import 'package:flutter/material.dart';

class ShowSingleProductResponseModel {
  bool? status;
  String? code;
  String? message;
  ProductModel? data;

  ShowSingleProductResponseModel({this.status, this.code, this.message, this.data});

  ShowSingleProductResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? ProductModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['status'] = status;
    result['code'] = code;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
    return result;
  }
}

class ProductModel {
  int? id;
  String? sku;
  String? name;
  String? desctiption;
  String? price;
  String? discountPrice;
  String? image;
  List<ImagesModel>? images;
  CategoryModel? category;
  List<SizeModel>? sizes;
  List<ColorModel>? colors;
  int? added_to_favouries;

  ProductModel({
    this.id,
    this.sku,
    this.name,
    this.desctiption,
    this.price,
    this.discountPrice,
    this.image,
    this.images,
    this.category,
    this.sizes,
    this.colors,
    this.added_to_favouries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku']??"";
    name = json['name'];
    desctiption = json['desctiption'];
    price = json['price'].toString();
    discountPrice = json['discount_price'].toString();
    image = json['image'];

    // images = json['images'] != null ? ImagesModel.fromJson(json['images']) : null;
    images = (json['images'] as List?)?.map((e) => ImagesModel.fromJson(e)).toList();;
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    sizes = (json['sizes'] as List?)?.map((e) => SizeModel.fromJson(e)).toList();
    colors = (json['colors'] as List?)?.map((e) => ColorModel.fromJson(e)).toList();
    added_to_favouries = json['added_to_favouries']??0;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['id'] = id;
    result['sku'] = sku;
    result['name'] = name;
    result['desctiption'] = desctiption;
    result['price'] = price;
    result['discount_price'] = discountPrice;
    result['image'] = image;
    result['images'] = images;
    result['category'] = category?.toJson();
    result['sizes'] = sizes?.map((e) => e.toJson()).toList();
    result['colors'] = colors?.map((e) => e.toJson()).toList();
    result['added_to_favouries'] = added_to_favouries;

    return result;
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? image;
  List<dynamic>? subcategories;

  CategoryModel({this.id, this.name, this.image, this.subcategories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    subcategories = json['subcategories'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'subcategories': subcategories,
    };
  }
}

class SizeModel {
  int? id;
  String? value;

  SizeModel({this.id, this.value});

  SizeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}

class ColorModel {
  int? id;
  String? value;

  ColorModel({this.id, this.value});

  ColorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
  Color get color {
    String hex = value!.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16)); // FF للشفافية الكاملة
  }
}
class ImagesModel {
  int? id;
  String? image;

  ImagesModel({this.id, this.image});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
