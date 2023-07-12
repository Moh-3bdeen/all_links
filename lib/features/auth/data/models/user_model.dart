class UserModel {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  String? country;
  String? ip;
  double? long;
  double? lat;
  String? fcm;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.country,
    required this.ip,
    required this.long,
    required this.lat,
    required this.fcm,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["user"]['id'];
    name = json["user"]['name'];
    email = json["user"]['email'];
    emailVerifiedAt = json["user"]['email_verified_at'];
    createdAt = json["user"]['created_at'];
    updatedAt = json["user"]['updated_at'];
    isActive = json["user"]['isActive'];
    country = json["user"]['country'];
    ip = json["user"]['ip'];
    long = json["user"]['long'];
    lat = json["user"]['lat'];
    fcm = json["user"]['fcm'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user']['id'] = id;
    data['user']['name'] = name;
    data['user']['email'] = email;
    data['user']['email_verified_at'] = emailVerifiedAt;
    data['user']['created_at'] = createdAt;
    data['user']['updated_at'] = updatedAt;
    data['user']['isActive'] = isActive;
    data['user']['country'] = country;
    data['user']['ip'] = ip;
    data['user']['long'] = long;
    data['user']['lat'] = lat;
    data['user']['fcm'] = fcm;
    data['token'] = token;
    return data;
  }
}
