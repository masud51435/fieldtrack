import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../models/home_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeResponseModel> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<HomeResponseModel> getHomeData() async {
    return await client.request(
      path: "/home",
      method: MethodType.get,
      parse: (json) => HomeResponseModel.fromJson(json),
    );
  }
}
