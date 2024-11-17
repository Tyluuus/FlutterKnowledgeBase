import 'package:dartz/dartz.dart';
import 'package:knowledge_base/features/riverpod/home/domain/repositories/home_repository.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class FetchCachedFirstListUseCase {
  final HomeRepository homeRepository;

  FetchCachedFirstListUseCase({required this.homeRepository});

  Future<Either<AppException, List<String>>> execute({required String type}) {
    return homeRepository.fetchCachedFirstList(type: type);
  }
}
