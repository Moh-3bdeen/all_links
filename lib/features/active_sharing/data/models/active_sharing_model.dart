import 'package:all_links/features/auth/data/models/user_model.dart';

class ActiveSharingModel{
  int? id;
  int? userId;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? distance;
  UserModel? user;

  ActiveSharingModel(this.id, this.userId, this.type, this.createdAt,
      this.updatedAt, this.distance, this.user);

  ActiveSharingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distance = json['distance'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['distance'] = distance;
    data['user'] = user?.toJson();
    return data;
  }


}