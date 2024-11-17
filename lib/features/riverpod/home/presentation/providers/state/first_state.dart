import 'package:equatable/equatable.dart';

enum FirstConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
}

class FirstState extends Equatable {
  final List<String> stringList;
  final int page;
  final int totalPages;
  final int totalResults;
  final bool hasData;
  final FirstConcreteState state;
  final String message;
  final bool isLoading;
  final bool cache;

  const FirstState({
    this.stringList = const [],
    this.page = 0,
    this.totalPages = 0,
    this.totalResults = 0,
    this.hasData = false,
    this.state = FirstConcreteState.initial,
    this.message = '',
    this.isLoading = false,
    this.cache = false,
  });

  const FirstState.initial({
    this.stringList = const [],
    this.page = 0,
    this.totalPages = 0,
    this.totalResults = 0,
    this.hasData = false,
    this.state = FirstConcreteState.initial,
    this.message = '',
    this.isLoading = false,
    this.cache = false,
  });

  FirstState copyWith({
    List<String>? stringList,
    int? page,
    int? totalPages,
    int? totalResults,
    bool? hasData,
    FirstConcreteState? state,
    String? message,
    bool? isLoading,
    bool? cache,
  }) {
    return FirstState(
        stringList: stringList ?? this.stringList,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
        hasData: hasData ?? this.hasData,
        state: state ?? this.state,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading,
        cache: cache ?? this.cache);
  }

  @override
  String toString() {
    return 'FirstState{stringList: $stringList, page: $page, totalPages: $totalPages, totalResults: $totalResults, hasData: $hasData, state: $state, message: '
        '$message, isLoading: $isLoading, cache: $cache}';
  }

  @override
  List<Object?> get props => [stringList, page, state, hasData, message, cache];
}
