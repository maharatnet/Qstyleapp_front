class NotificationResponseModel {
  bool? status;
  String? code;
  String? message;
  List<NotificationModel>? data;

  NotificationResponseModel({this.status, this.code, this.message, this.data});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(new NotificationModel.fromJson(v));
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

class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? type;
  NotificationInformationModel? data;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
        this.title,
        this.body,
        this.type,
        this.data,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    data = json['data'] != null ? new NotificationInformationModel.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NotificationInformationModel {
  int? id;
  int? total;
  String? paymentMethod;
  int? paymentStatus;
  Status? status;
  String? createdAt;
  String? updatedAt;

  NotificationInformationModel(
      {this.id,
        this.total,
        this.paymentMethod,
        this.paymentStatus,
        this.status,
        this.createdAt,
        this.updatedAt});

  NotificationInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
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

