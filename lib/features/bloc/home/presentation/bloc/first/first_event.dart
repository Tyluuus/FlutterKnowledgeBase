part of 'first_bloc.dart';

sealed class FirstEvent extends Equatable {
  const FirstEvent();

  @override
  List<Object?> get props => [];
}

final class GetFistListEvent extends FirstEvent {
  final String type;
  const GetFistListEvent({required this.type});
}
