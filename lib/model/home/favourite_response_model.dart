class FavouriteResponseModel {
  bool? status;
  String? code;
  String? message;
  List<FavouriteModel>? data;

  FavouriteResponseModel({this.status, this.code, this.message, this.data});

  FavouriteResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavouriteModel>[];
      json['data'].forEach((v) {
        data!.add(new FavouriteModel.fromJson(v));
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

class FavouriteModel {
  int? id;
  String? sku;
  String? name;
  String? desctiption;
  String? price;
  String? discountPrice;
  String? image;
  int? addedToFavouries;

  FavouriteModel(
      {this.id,
        this.sku,
        this.name,
        this.desctiption,
        this.price,
        this.discountPrice,
        this.image,
        this.addedToFavouries});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    desctiption = json['desctiption'];
    price = json['price'].toString();
    discountPrice = json['discount_price'].toString();
    image = json['image'];
    addedToFavouries = json['added_to_favouries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['desctiption'] = this.desctiption;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['image'] = this.image;
    data['added_to_favouries'] = this.addedToFavouries;
    return data;
  }
}