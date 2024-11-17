import 'package:equatable/equatable.dart';

enum SecondConcreteState { initial, loading, loaded, failure }

class SecondState extends Equatable {
  final List<int> intList;
  final bool hasData;
  final String message;
  final SecondConcreteState state;
  final bool isLoading;

  const SecondState({this.intList = const [], this.hasData = false, this.message = '', this.state = SecondConcreteState.initial, this.isLoading = false});

  const SecondState.initial(
      {this.intList = const [], this.hasData = false, this.message = '', this.state = SecondConcreteState.initial, this.isLoading = false});

  SecondState copyWith({List<int>? intList, bool? hasData, String? message, SecondConcreteState? state, bool? isLoading}) {
    return SecondState(
        intList: intList ?? this.intList,
        message: message ?? this.message,
        hasData: hasData ?? this.hasData,
        state: state ?? this.state,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [intList, message, hasData, state, isLoading];
}
