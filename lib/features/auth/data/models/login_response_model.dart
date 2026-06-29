import '../../domain/entities/user_entity.dart';

class LoginResponseModel {
  final bool? status;
  final String? message;
  final LoginDataModel? data;

  LoginResponseModel({this.status, this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? LoginDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  UserEntity toEntity(String email) {
    return UserEntity(token: data?.token ?? '', email: email);
  }
}

class LoginDataModel {
  final String? token;

  LoginDataModel({this.token});

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(token: json['token'] as String?);
  }
}
