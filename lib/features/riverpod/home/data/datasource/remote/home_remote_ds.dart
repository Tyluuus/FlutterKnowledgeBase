import 'package:dartz/dartz.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

abstract class HomeRemoteDataSource {
  Future<Either<AppException, NetworkResponse>> getFirstList({required String endPoint, required int page});

  Future<Either<AppException, NetworkResponse>> getSecondList();
}

// Helping class to avoid errors marking.
class NetworkResponse {}
