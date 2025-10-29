part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final int userId;

  const LoadUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class RefreshUser extends UserEvent {
  final int userId;

  const RefreshUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class LoadCachedUser extends UserEvent {}

class ClearUser extends UserEvent {}
