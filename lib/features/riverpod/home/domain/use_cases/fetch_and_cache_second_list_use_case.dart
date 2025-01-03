import 'package:dartz/dartz.dart';
import 'package:knowledge_base/features/riverpod/home/domain/repositories/home_repository.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class FetchAndCacheSecondListUseCase {
  final HomeRepository homeRepository;

  FetchAndCacheSecondListUseCase({required this.homeRepository});

  Future<Either<AppException, List<int>>> execute() {
    return homeRepository.fetchAndCacheSecondList();
  }
}
