import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base/di/example/injector.dart';
import 'package:knowledge_base/features/bloc/home/domain/use_cases/fetch_and_cache_second_list_use_case.dart';
import 'package:knowledge_base/features/bloc/home/domain/use_cases/fetch_cached_second_list_use_case.dart';
import 'package:knowledge_base/features/bloc/home/presentation/bloc/second/second_event.dart';
import 'package:knowledge_base/features/bloc/home/presentation/bloc/second/second_state.dart';
import 'package:knowledge_base/shared/utils/example/app_exception.dart';

class SecondBloc extends Bloc<SecondEvent, SecondState> {
  final FetchCachedSecondListUseCase _fetchCacheGenre = injector.get<FetchCachedSecondListUseCase>();
  final FetchAndCacheSecondListUseCase _fetchAndCacheGenre = injector.get<FetchAndCacheSecondListUseCase>();

  SecondBloc() : super(const SecondState.initial()) {
    on<GetSecondLocalEvent>(_getSecondLocal);
    on<GetSecondRemoteEvent>(_getSecondRemote);
  }
  bool get isFetching => state.state != SecondConcreteState.loading;

  Future<void> _getSecondLocal(GetSecondLocalEvent event, Emitter<SecondState> emit) async {
    if (isFetching) {
      emit(state.copyWith(
        state: SecondConcreteState.loading,
        isLoading: true,
      ));
      final cached = await _fetchCacheGenre.execute();
      cached.fold((failure) {
        emit(state.copyWith(
          state: SecondConcreteState.failure,
          isLoading: false,
        ));
        add(const GetSecondRemoteEvent());
      }, (success) {
        updateStateFromSecondListResponse(cached, emit);
      });
    }
  }

  Future<void> _getSecondRemote(GetSecondRemoteEvent event, Emitter<SecondState> emit) async {
    if (isFetching) {
      emit(state.copyWith(
        state: SecondConcreteState.loading,
        isLoading: true,
      ));
      final response = await _fetchAndCacheGenre.execute();
      updateStateFromSecondListResponse(response, emit);
    }
  }

  void updateStateFromSecondListResponse(Either<AppException, List<int>> response, emit) {
    response.fold((failure) {
      emit(state.copyWith(state: SecondConcreteState.failure, message: failure.message, isLoading: false));
    }, (success) {
      emit(state.copyWith(intList: [], hasData: true, message: [].isEmpty ? 'No genre found' : '', isLoading: false, state: SecondConcreteState.loaded));
    });
  }
}
