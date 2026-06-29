import '../../../network/api_client.dart';
import '../../../network/method_types.dart';
import '../../../network/links.dart';
import '../models/country_response_model.dart';

abstract class CommonRemoteDataSource {
  Future<CountryResponseModel> getCountries();
}

class CommonRemoteDataSourceImpl implements CommonRemoteDataSource {
  final ApiClient client;

  CommonRemoteDataSourceImpl({required this.client});

  @override
  Future<CountryResponseModel> getCountries() async {
    return await client.request(
      path: "/get-countries", // Common endpoints can stay in links.dart or here
      method: MethodType.get,
      parse: (json) => CountryResponseModel.fromJson(json),
    );
  }
}
