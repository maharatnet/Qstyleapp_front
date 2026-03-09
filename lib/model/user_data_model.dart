class UserDataModel {
  final bool status;
  final String code;
  final String message;
  final UserData? data;

  UserDataModel({
    required this.status,
    required this.code,
    required this.message,
    this.data,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      status: json['status'] ?? false,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'data': data?.toJson(),
  };
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String? mobile;
  final String? photoProfile;
  final String? deviceType;
  final String? fcmToken;
  final String? gender;
  final String? access_token;
  final String? lang;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.mobile,
    this.photoProfile,
    this.deviceType,
    this.fcmToken,
    this.gender,
    this.access_token,
    this.lang,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile']??"",
      photoProfile: json['photo_profile']??"",
      deviceType: json['device_type']??"",
      fcmToken: json['fcm_token']??"",
      gender: json['gender']??"",
      access_token: json['access_token']??"",
      lang: json['lang']??"",
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'mobile': mobile,
    'photo_profile': photoProfile,
    'device_type': deviceType,
    'fcm_token': fcmToken,
    'gender': gender,
    'access_token': access_token,
    'lang': lang,
  };
}
