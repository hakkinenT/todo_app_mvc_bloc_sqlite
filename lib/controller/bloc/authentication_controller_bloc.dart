import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/model.dart';
import '../../repositories/repositories.dart';

part 'authentication_controller_event.dart';
part 'authentication_controller_state.dart';

class AuthenticationControllerBloc
    extends Bloc<AuthenticationControllerEvent, AuthenticationControllerState> {
  final AuthRepository authRepository;

  AuthenticationControllerBloc({required this.authRepository})
      : super(authRepository.currentUser.isNotEmpty
            ? AuthenticationControllerState.authentication(
                authRepository.currentUser)
            : const AuthenticationControllerState.unauthenticated()) {
    on<AuthenticationUserChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    _userSubscription = authRepository.user
        .listen((user) => add(AuthenticationUserChanged(user)));
  }

  late final StreamSubscription<User> _userSubscription;

  Future<void> _onUserChanged(AuthenticationUserChanged event,
      Emitter<AuthenticationControllerState> emit) async {
    emit(event.user.isNotEmpty
        ? AuthenticationControllerState.authentication(event.user)
        : const AuthenticationControllerState.unauthenticated());
  }

  Future<void> _onLogoutRequested(AuthenticationLogoutRequested event,
      Emitter<AuthenticationControllerState> emit) async {
    unawaited(authRepository.loggout());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
