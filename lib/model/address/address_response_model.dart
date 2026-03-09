// class AddressResponseModel {
//   bool? status;
//   String? code;
//   String? message;
//   List<AddressModel>? data;
//
//   AddressResponseModel({this.status, this.code, this.message, this.data});
//
//   AddressResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     code = json['code'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <AddressModel>[];
//       json['data'].forEach((v) {
//         data!.add(new AddressModel.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class AddressModel {
//   int? id;
//   String? name;
//   String? description;
//   String? latitude;
//   String? longitude;
//   int? isDefault;
//
//   AddressModel(
//       {this.id,
//         this.name,
//         this.description,
//         this.latitude,
//         this.longitude,
//         this.isDefault});
//
//   AddressModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     isDefault = json['is_default'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['is_default'] = this.isDefault;
//     return data;
//   }
// }
//
//

class AddressResponseModel {
  bool? status;
  String? code;
  String? message;
  List<AddressModel>? data;

  AddressResponseModel({this.status, this.code, this.message, this.data});

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressModel>[];
      json['data'].forEach((v) {
        data!.add(new AddressModel.fromJson(v));
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

class AddressModel {
  int? id;
  CountryModel? country;
  String? city;
  String? name;
  String? description;
  String? latitude;
  String? longitude;
  int? isDefault;

  AddressModel({
    this.id,
    this.country,
    this.city,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.isDefault
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'] != null
        ? new CountryModel.fromJson(json['country'])
        : null;
    city = json['city'];
    name = json['name'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['city'] = this.city;
    data['name'] = this.name;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class CountryModel {
  int? id;
  String? name;
  int? shippingFees;

  CountryModel({this.id, this.name, this.shippingFees});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shippingFees = json['shipping_fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shipping_fees'] = this.shippingFees;
    return data;
  }
}