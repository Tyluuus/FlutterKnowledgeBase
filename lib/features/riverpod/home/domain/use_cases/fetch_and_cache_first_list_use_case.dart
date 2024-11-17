import 'package:dartz/dartz.dart';
import 'package:knowledge_base/features/riverpod/home/domain/repositories/home_repository.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class FetchAndCacheFirstListUseCase {
  final HomeRepository homeRepository;

  FetchAndCacheFirstListUseCase({required this.homeRepository});

  Future<Either<AppException, List<String>>> execute({required int page, required String type}) {
    return homeRepository.fetchAndCacheFirstList(page: page, type: type);
  }
}
