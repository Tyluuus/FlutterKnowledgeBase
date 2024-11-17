import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowledge_base/di/example/injector.dart';
import 'package:knowledge_base/features/riverpod/home/domain/use_cases/fetch_and_cache_second_list_use_case.dart';
import 'package:knowledge_base/features/riverpod/home/domain/use_cases/fetch_cached_second_list_use_case.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/second_state.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class SecondNotifier extends StateNotifier<SecondState> {
  // final HomeRepository homeRepository = injector.get<HomeRepository>();

  final FetchAndCacheSecondListUseCase _fetchAndCachedSecondListUseCase = injector.get<FetchAndCacheSecondListUseCase>();
  final FetchCachedSecondListUseCase _fetchCachedSecondListsUseCase = injector.get<FetchCachedSecondListUseCase>();

  SecondNotifier() : super(const SecondState.initial());

  bool get isFetching => state.state != SecondConcreteState.loading;

  Future<void> getGenres() async {
    if (isFetching) {
      state = state.copyWith(
        state: SecondConcreteState.loading,
        isLoading: true,
      );
      final cached = await _fetchCachedSecondListsUseCase.execute();
      cached.fold((failure) async {
        state = state.copyWith(isLoading: true);
        final response = await _fetchAndCachedSecondListUseCase.execute();
        updateStateFromSecondListResponse(response);
      }, (success) {
        updateStateFromSecondListResponse(cached);
      });
    }
  }

  void updateStateFromSecondListResponse(Either<AppException, List<int>> response) {
    response.fold((failure) {
      state = state.copyWith(state: SecondConcreteState.failure, message: failure.message, isLoading: false);
    }, (success) {
      state = state.copyWith(intList: [], hasData: true, message: [].isEmpty ? 'No genre found' : '', isLoading: false, state: SecondConcreteState.loaded);
    });
  }

  void resetState() {
    state = const SecondState.initial();
  }
}
