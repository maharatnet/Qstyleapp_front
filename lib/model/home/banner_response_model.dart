class BannerResponseModel {
  bool? status;
  String? code;
  String? message;
  List<BannerModel>? data;

  BannerResponseModel({this.status, this.code, this.message, this.data});

  BannerResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerModel>[];
      json['data'].forEach((v) {
        data!.add(new BannerModel.fromJson(v));
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

class BannerModel {
  int? id;
  String? image;
  String? title;
  String? url;

  BannerModel({this.id, this.image});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title']??"";
    url = json['url']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}