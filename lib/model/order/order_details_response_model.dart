class OrderDetailsResponseModel {
  bool? status;
  String? code;
  String? message;
  OrderDetails? data;

  OrderDetailsResponseModel({this.status, this.code, this.message, this.data});

  OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new OrderDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? id;
  User? user;
  int? total;
  String? country;
  String? city;
  String? description;
  int? paymentStatus;
  String? paymentMethod;
  Status? status;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;

  OrderDetails(
      {this.id,
        this.user,
        this.total,
        this.country,
        this.city,
        this.description,
        this.paymentStatus,
        this.paymentMethod,
        this.status,
        this.items,
        this.createdAt,
        this.updatedAt});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    total = json['total'];
    country = json['country']??"";
    city = json['city']??"";
    description = json['description']??"";
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['total'] = this.total;
    data['country'] = this.country;
    data['city'] = this.city;
    data['description'] = this.description;
    data['payment_status'] = this.paymentStatus;
    data['payment_method'] = this.paymentMethod;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? photoProfile;
  // Null? deviceType;
  String? fcmToken;
  String? lang;

  User(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.gender,
        this.photoProfile,
        // this.deviceType,
        this.fcmToken,
        this.lang});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    photoProfile = json['photo_profile'];
    // deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['photo_profile'] = this.photoProfile;
    // data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    data['lang'] = this.lang;
    return data;
  }
}

class Status {
  int? id;
  String? status;

  Status({this.id, this.status});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}

class Items {
  int? id;
  Product? product;
  Size? size;
  Size? color;
  String? price;
  int? quantity;
  int? total;

  Items(
      {this.id,
        this.product,
        this.size,
        this.color,
        this.price,
        this.quantity,
        this.total});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    color = json['color'] != null ? new Size.fromJson(json['color']) : null;
    price = json['price'].toString();
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}

class Product {
  int? id;
  String? sku;
  String? name;
  String? desctiption;
  String? price;
  String? discountPrice;
  String? image;
  int? addedToFavouries;

  Product(
      {this.id,
        this.sku,
        this.name,
        this.desctiption,
        this.price,
        this.discountPrice,
        this.image,
        this.addedToFavouries});

  Product.fromJson(Map<String, dynamic> json) {
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

class Size {
  int? id;
  String? value;

  Size({this.id, this.value});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}