import 'package:equatable/equatable.dart';

sealed class SecondEvent extends Equatable {
  const SecondEvent();

  @override
  List<Object?> get props => [];
}

final class GetSecondLocalEvent extends SecondEvent {
  const GetSecondLocalEvent();
}

final class GetSecondRemoteEvent extends SecondEvent {
  const GetSecondRemoteEvent();
}
