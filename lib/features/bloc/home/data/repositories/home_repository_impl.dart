import 'package:dartz/dartz.dart';
import 'package:knowledge_base/app/example/app_configs.dart';
import 'package:knowledge_base/features/riverpod/home/data/datasource/local/home_local_ds.dart';
import 'package:knowledge_base/features/riverpod/home/data/datasource/remote/home_remote_ds.dart';
import 'package:knowledge_base/features/riverpod/home/domain/repositories/home_repository.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource, required this.homeLocalDataSource});

  @override
  Future<Either<AppException, List<String>>> fetchAndCacheFirstList({required int page, required String type}) async {
    final response = await homeRemoteDataSource.getFirstList(endPoint: type, page: page);
    return response.fold((failure) => Left(failure), (success) {
      /// Deserialization of Network response
      // final list = success.results.map((e) => FirstList.fromJson(e)).toList();

      if (AppConfigs.shouldCache) {
        homeLocalDataSource.cacheFirstList(firstList: []); // Cache Page 0
      }
      return const Right([]);
    });
  }

  @override
  Future<Either<AppException, List<int>>> fetchAndCacheSecondList() async {
    final response = await homeRemoteDataSource.getSecondList();
    return response.fold((failure) => Left(failure), (success) {
      homeLocalDataSource.cacheSecondList(secondList: []);
      return const Right([]);
    });
  }

  @override
  Future<Either<AppException, List<int>>> fetchCachedSecondList() {
    return homeLocalDataSource.getCacheSecondList();
  }

  @override
  Future<Either<AppException, List<String>>> fetchCachedFirstList({required String type}) {
    return homeLocalDataSource.getCacheFirstList();
  }
}
