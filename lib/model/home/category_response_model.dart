// class CategoryResponseModel {
//   bool? status;
//   String? code;
//   String? message;
//   List<CategoryModel>? data;
//
//   CategoryResponseModel({this.status, this.code, this.message, this.data});
//
//   CategoryResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     code = json['code'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <CategoryModel>[];
//       json['data'].forEach((v) {
//         data!.add(new CategoryModel.fromJson(v));
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
// class CategoryModel {
//   int? id;
//   String? name;
//   String? image;
//   List<Subcategories>? subcategories;
//
//   CategoryModel({this.id, this.name, this.image, this.subcategories});
//
//   CategoryModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     if (json['subcategories'] != null) {
//       subcategories = <Subcategories>[];
//       json['subcategories'].forEach((v) {
//         subcategories!.add(new Subcategories.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     if (this.subcategories != null) {
//       data['subcategories'] =
//           this.subcategories!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Subcategories {
//   int? id;
//   String? name;
//   String? image;
//
//   Subcategories({this.id, this.name, this.image});
//
//   Subcategories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     return data;
//   }
// }
class CategoryResponseModel {
  bool? status;
  String? code;
  String? message;
  List<CategoryModel>? data;

  CategoryResponseModel({this.status, this.code, this.message, this.data});

  CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryModel.fromJson(v));
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

class CategoryModel {
  int? id;
  String? name;
  String? image;
  int? is_international;
  List<Subcategories>? subcategories;

  CategoryModel({this.id, this.name, this.image,this.is_international ,this.subcategories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    is_international = json['is_international']??0;
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_international'] = this.is_international;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int? id;
  String? name;
  String? image;
  int? is_international;
  List<BrandModel>? brands;

  Subcategories({this.id, this.name, this.image,this.is_international,this.brands});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    is_international = json['is_international']??0;
    if (json['brands'] != null) {
      brands = <BrandModel>[];
      json['brands'].forEach((v) {
        brands!.add(new BrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_international'] = this.is_international;
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandModel {
  int? id;
  String? name;
  String? image;
  int? isInterantional;


  BrandModel({this.id, this.name, this.image,this.isInterantional});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isInterantional = json['is_international']??0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_international'] = this.isInterantional;

    return data;
  }
}
