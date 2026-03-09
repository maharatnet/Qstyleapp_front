import 'package:maharat_ecommerce/model/home/category_response_model.dart';

class CategoryProductResponseModel {
  bool? status;
  String? code;
  String? message;
  List<CategoryProductModel>? data;

  CategoryProductResponseModel(
      {this.status, this.code, this.message, this.data});

  CategoryProductResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryProductModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryProductModel {
  int? id;
  String? sku;
  String? name;
  String? desctiption;
  String? price;
  String? discountPrice;
  BrandModel? brand;
  String? image;

  CategoryProductModel(
      {this.id,
        this.sku,
        this.name,
        this.desctiption,
        this.price,
        this.discountPrice,
        this.brand,
        this.image});

  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku']??"";
    name = json['name'];
    desctiption = json['desctiption'];
    price = json['price'].toString();
    discountPrice = json['discount_price'].toString();
    brand = json['brand'] != null ? new BrandModel.fromJson(json['brand']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['desctiption'] = this.desctiption;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}



