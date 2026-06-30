import '../../domain/entities/user_entity.dart';

class LoginResponseModel {
  User? user;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  LoginResponseModel({
    this.user,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "expires_in": expiresIn,
  };

  UserEntity toEntity(String email) {
    return UserEntity(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
      email: user?.email ?? email,
      name: user?.name,
      role: user?.role,
      id: user?.id,
    );
  }
}

class User {
  String? email;
  String? role;
  String? id;
  String? name;

  User({this.email, this.role, this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
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
