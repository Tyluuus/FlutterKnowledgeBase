import 'package:dartz/dartz.dart';
import 'package:knowledge_base/features/riverpod/home/data/datasource/remote/home_remote_ds.dart';
import 'package:knowledge_base/shared/network/example/network_service.dart';
import 'package:knowledge_base/shared/network/example/network_values.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final NetworkService networkService;

  HomeRemoteDataSourceImpl({required this.networkService});

  @override
  Future<Either<AppException, NetworkResponse>> getFirstList({required String endPoint, required int page}) async {
    final response = await networkService.get(endPoint, queryParams: {
      Params.page: page,
    });

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(identifier: endPoint, statusCode: 0, message: 'The data is not in the valid format', which: 'http'),
        );
      }

      /// Deserialize data to be useful.
      // final response = Response.fromJson(jsonData, jsonData['results'] ?? []);
      return Left(AppException(identifier: endPoint, statusCode: 0, message: 'The data is not in the valid format', which: 'http'));
    });
  }

  @override
  Future<Either<AppException, NetworkResponse>> getSecondList() async {
    final response = await networkService.get(EndPoints.second);
    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(AppException(identifier: EndPoints.second, statusCode: 0, message: 'The data is not in the valid format', which: 'http'));
      }
      // final response = Response(jsonData['genres'] ?? []);
      return Left(AppException(identifier: EndPoints.second, statusCode: 0, message: 'The data is not in the valid format', which: 'http'));
    });
  }
}
