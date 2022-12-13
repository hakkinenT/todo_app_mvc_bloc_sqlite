part of 'authentication_controller_bloc.dart';

abstract class AuthenticationControllerEvent extends Equatable {
  const AuthenticationControllerEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationControllerEvent {
  const AuthenticationLogoutRequested();
}

class AuthenticationUserChanged extends AuthenticationControllerEvent {
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
