import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowledge_base/di/example/injector.dart';
import 'package:knowledge_base/features/riverpod/home/domain/use_cases/fetch_and_cache_first_list_use_case.dart';
import 'package:knowledge_base/features/riverpod/home/domain/use_cases/fetch_cached_first_list_use_case.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/first_state.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class FirstNotifier extends StateNotifier<FirstState> {
  final FetchAndCacheFirstListUseCase _fetchAndCacheFirstListUseCase = injector.get<FetchAndCacheFirstListUseCase>();
  final FetchCachedFirstListUseCase _fetchCachedFirstListUseCase = injector.get<FetchCachedFirstListUseCase>();

  FirstNotifier() : super(const FirstState.initial());

  bool get isFetching => state.state != FirstConcreteState.loading && state.state != FirstConcreteState.fetchingMore;

  Future<void> getFirstList({required String type}) async {
    if (state.state == FirstConcreteState.initial) {
      final stringList = await _fetchCachedFirstListUseCase.execute(type: type);
      updateStateFromGetFirstListResponse(stringList);
    }
    if (isFetching && state.state != FirstConcreteState.loaded) {
      state = state.copyWith(
        state: state.page > 0 ? FirstConcreteState.fetchingMore : FirstConcreteState.loading,
        isLoading: true,
      );
      final stringList = await _fetchAndCacheFirstListUseCase.execute(page: state.page + 1, type: type);
      updateStateFromGetFirstListResponse(stringList);
    } else {
      state = state.copyWith(state: FirstConcreteState.loaded, message: 'No more movies left', isLoading: false);
    }
  }

  void updateStateFromGetFirstListResponse(Either<AppException, List<String>> response) {
    response.fold((failure) {
      state = state.copyWith(state: FirstConcreteState.failure, message: failure.message, isLoading: false);
    }, (stringList) {
      if (state.cache) {
        state = state.copyWith(stringList: []);
      }
      final totalList = [...state.stringList];
      state = state.copyWith(
          stringList: totalList,
          state: FirstConcreteState.loaded,
          hasData: true,
          cache: false,
          message: stringList.isEmpty ? 'No Strings Found' : '',
          page: 0,
          totalPages: 0,
          isLoading: false);
    });
  }

  void resetState() {
    state = const FirstState.initial();
  }
}
