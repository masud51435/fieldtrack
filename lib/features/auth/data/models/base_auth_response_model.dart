class BaseAuthResponseModel {
  final bool? status;
  final String? message;

  BaseAuthResponseModel({this.status, this.message});

  factory BaseAuthResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseAuthResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );
  }
}
