import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base/di/example/injector.dart';
import 'package:knowledge_base/features/bloc/home/domain/use_cases/fetch_and_cache_first_list_use_case.dart';
import 'package:knowledge_base/features/bloc/home/domain/use_cases/fetch_cached_first_list_use_case.dart';
import 'package:knowledge_base/features/riverpod/home/presentation/providers/state/first_state.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

part 'first_event.dart';
part 'first_state.dart';

sealed class FirstBloc extends Bloc<FirstEvent, FirstState> {
  final FetchAndCacheFirstListUseCase _fetchAndCacheFirstList = injector.get<FetchAndCacheFirstListUseCase>();
  final FetchCachedFirstListUseCase _fetchCachedFirstList = injector.get<FetchCachedFirstListUseCase>();

  bool get isFetching => state.state != FirstConcreteState.loading && state.state != FirstConcreteState.fetchingMore;

  FirstBloc() : super(const FirstState.initial()) {
    on<GetFistListEvent>(getFirstList);
  }

  Future<void> getFirstList(GetFistListEvent event, Emitter<FirstState> emit) async {
    if (state.state == FirstConcreteState.initial) {
      final firstList = await _fetchCachedFirstList.execute(type: event.type);
      updateStateFromGetFirstListResponse(firstList, emit);
    }

    if (isFetching) {
      emit(state.copyWith(
        state: state.page > 0 ? MoviesConcreteState.fetchingMore : MoviesConcreteState.loading,
        isLoading: true,
      ));
      final firstList = await _fetchAndCacheFirstList.execute(page: state.page + 1, type: event.type);
      updateStateFromGetFirstListResponse(firstList, emit);
    } else {
      emit(state.copyWith(state: MoviesConcreteState.loaded, message: 'No more movies left', isLoading: false));
    }
  }

  void updateStateFromGetFirstListResponse(Either<AppException, List<String>> response, Emitter<FirstState> emit) {
    response.fold((failure) {
      emit(state.copyWith(state: MoviesConcreteState.failure, message: failure.message, isLoading: false));
    }, (strings) {
      if (state.cache) {
        emit(state.copyWith(stringList: []));
      }
      final totalStrings = [...state.stringList];
      emit(state.copyWith(
          stringList: totalStrings,
          state: MoviesConcreteState.loaded,
          hasData: true,
          message: totalStrings.isEmpty ? 'No Movies Found' : '',
          isLoading: false));
    });
  }
}

final class GetFirstListBloc extends FirstBloc {
  GetFirstListBloc();
}
