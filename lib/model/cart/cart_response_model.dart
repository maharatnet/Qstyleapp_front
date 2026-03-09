class CartResponseModel {
  bool? status;
  String? code;
  String? message;
  List<CartModel>? data;
  double? cartTotal;
  double? discount;
  double? shipping_fees;
  double? total;

  CartResponseModel(
      {this.status, this.code, this.message, this.data, this.cartTotal});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartModel>[];
      json['data'].forEach((v) {
        data!.add(new CartModel.fromJson(v));
      });
    }
    cartTotal = double.parse(json['cart_total']==null?"0.0":"${json['cart_total'].toString()}");
    discount = double.parse(json['discount']==null?"0.0":"${json['discount'].toString()}");
    shipping_fees = double.parse(json['shipping_fees']==null?"0.0":"${json['shipping_fees'].toString()}");
    total = double.parse(json['total']==null?"0.0":"${json['total'].toString()}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['cart_total'] = this.cartTotal;
    data['discount'] = this.discount;
    data['shipping_fees'] = this.shipping_fees;
    data['total'] = this.total;

    return data;
  }
}

class CartModel {
  int? id;
  Product? product;
  Size? size;
  Size? color;
  String? quantity;

  CartModel({this.id, this.product, this.size, this.color, this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    color = json['color'] != null ? new Size.fromJson(json['color']) : null;
    quantity = json['quantity'];
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
    data['quantity'] = this.quantity;
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

