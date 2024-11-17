import 'package:dartz/dartz.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheFirstList({required List<String> firstList});

  Future<void> cacheSecondList({required List<int> secondList});

  Future<Either<AppException, List<String>>> getCacheFirstList();

  Future<Either<AppException, List<int>>> getCacheSecondList();
}
