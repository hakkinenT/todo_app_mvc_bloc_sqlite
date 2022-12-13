import '../model/model.dart';
import '../services/services.dart';

abstract class AuthRepository {
  Stream<User> get user;
  User get currentUser;
  Future<void> registerUser(User user);
  Future<void> login(User user);
  Future<void> loggout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  User get currentUser => authService.currentUser;

  @override
  Future<void> login(User user) => authService.login(user);

  @override
  Future<void> loggout() => authService.loggout();

  @override
  Future<void> registerUser(User user) => authService.registerUser(user);

  @override
  Stream<User> get user => authService.user;
}
