import 'package:dartz/dartz.dart';
import 'package:knowledge_base/features/riverpod/home/data/datasource/local/home_local_ds.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  HomeLocalDataSourceImpl();

  @override
  Future<void> cacheFirstList({required List<String> firstList}) async {
    // Save to local database - cache.
  }

  @override
  Future<void> cacheSecondList({required List<int> secondList}) async {
    // Save to local database - cache.
  }

  @override
  Future<Either<AppException, List<int>>> getCacheSecondList() async {
    // Get cached data from local database and return it (or exception / null if there were no data).
    return Left(AppException(message: 'Genre not cached', statusCode: 0, identifier: 'secondList', which: 'cache'));
  }

  @override
  Future<Either<AppException, List<String>>> getCacheFirstList() async {
    // Get cached data from local database and return it (or exception / null if there were no data).

    return Left(AppException(message: 'Cache not Found', statusCode: 0, identifier: 'firstList', which: 'cache'));
  }
}
