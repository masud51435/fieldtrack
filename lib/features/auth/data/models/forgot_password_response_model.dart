class ForgotPasswordResponseModel {
  final bool? status;
  final String? message;

  ForgotPasswordResponseModel({this.status, this.message});

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );
  }
}
