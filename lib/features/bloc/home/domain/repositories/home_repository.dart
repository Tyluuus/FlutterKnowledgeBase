import 'package:dartz/dartz.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

abstract class HomeRepository {
  Future<Either<AppException, List<String>>> fetchAndCacheFirstList({required int page, required String type});

  Future<Either<AppException, List<int>>> fetchAndCacheSecondList();

  Future<Either<AppException, List<int>>> fetchCachedSecondList();

  Future<Either<AppException, List<String>>> fetchCachedFirstList({required String type});
}
