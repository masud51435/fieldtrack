import 'country_model.dart';

class CountryResponseModel {
  final bool? status;
  final String? message;
  final List<CountryModel>? data;
  final dynamic meta;

  CountryResponseModel({this.status, this.message, this.data, this.meta});

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'],
    );
  }
}
