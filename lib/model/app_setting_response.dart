class AppSettingsResponse {
  final bool status;
  final String code;
  final String message;
  final AppSettingsData? data;

  AppSettingsResponse({
    required this.status,
    required this.code,
    required this.message,
    this.data,
  });

  factory AppSettingsResponse.fromJson(Map<String, dynamic> json) {
    return AppSettingsResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? AppSettingsData.fromJson(json['data']) : null,
    );
  }
}

class AppSettingsData {
  final String? about;
  final String? terms;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? telegram;
  final String? luxury_color;
  final int isUserHasAddress;
  final List<OrderStatusModel> orderStatuses;
  final int unreadNotifications;
  List<CountriesModel>? countries;

  AppSettingsData({
    this.about,
    this.terms,
    this.facebook,
    this.instagram,
    this.twitter,
    this.telegram,
    this.luxury_color,
    required this.isUserHasAddress,
    required this.orderStatuses,
    required this.unreadNotifications,
    required this.countries,
  });

  factory AppSettingsData.fromJson(Map<String, dynamic> json) {
    var statusList = json['order_statuses'] as List;
    List<OrderStatusModel> orderStatusList =
    statusList.map((i) => OrderStatusModel.fromJson(i)).toList();
    var countriesList = json['countries'] as List;
    List<CountriesModel> countriesStatusList =
    countriesList.map((i) => CountriesModel.fromJson(i)).toList();

  //   if (json['countries'] != null) {
  //     countries = <Countries>[];
  //     json['countries'].forEach((v) {
  //       countries!.add(new Countries.fromJson(v));
  //     });
  //   }
  // }
    return AppSettingsData(
      about: json['about']??"",
      terms: json['terms']??"",
      facebook: json['facebook']??"",
      instagram: json['instagram']??"",
      twitter: json['twitter']??"",
      telegram: json['telegram']??"",
      luxury_color: json['luxury_color']??"#ead91f",
      isUserHasAddress: json['is_user_has_address'],
      orderStatuses: orderStatusList,
      unreadNotifications: json['unread_notifications']??0,
      countries: countriesStatusList,
    );
  }
}

class OrderStatusModel {
  final int id;
  final String status;

  OrderStatusModel({
    required this.id,
    required this.status,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      id: json['id'],
      status: json['status']??"",
    );
  }
}

class CountriesModel {
  int? id;
  String? name;
  int? shippingFees;

  CountriesModel({this.id, this.name, this.shippingFees});

  CountriesModel.fromJson(Map<String, dynamic> json) {
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