class OrderResponseModel {
  bool? status;
  String? code;
  String? message;
  List<OrderModel>? data;

  OrderResponseModel({this.status, this.code, this.message, this.data});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderModel>[];
      json['data'].forEach((v) {
        data!.add(new OrderModel.fromJson(v));
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

class OrderModel {
  int? id;
  int? total;
  Status? status;
  String? createdAt;
  String? updatedAt;

  OrderModel({this.id, this.total, this.status, this.createdAt, this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

