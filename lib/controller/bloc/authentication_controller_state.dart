part of 'authentication_controller_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationControllerState extends Equatable {
  const AuthenticationControllerState._(
      {required this.status, this.user = User.empty});

  const AuthenticationControllerState.authentication(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationControllerState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
