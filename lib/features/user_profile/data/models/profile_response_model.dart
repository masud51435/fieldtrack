import '../../domain/entities/profile_entity.dart';

class ProfileResponseModel {
  String? email;
  String? role;
  String? id;
  String? name;

  ProfileResponseModel({this.email, this.role, this.id, this.name});

  ProfileEntity toEntity() {
    return ProfileEntity(
      email: email ?? '',
      role: role ?? '',
      id: id ?? '',
      name: name ?? '',
    );
  }

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        email: json["email"],
        role: json["role"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "role": role,
    "id": id,
    "name": name,
  };
}
