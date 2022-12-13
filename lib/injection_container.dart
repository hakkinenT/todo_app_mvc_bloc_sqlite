import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/controller.dart';
import 'core/themes/themes.dart';
import 'dao/dao.dart';
import 'repositories/repositories.dart';
import 'services/services.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! BLOC / CUBIT
  sl.registerFactory(() => AuthenticationControllerBloc(authRepository: sl()));
  sl.registerFactory(() => TodoControllerBloc(todoRepository: sl()));
  sl.registerFactory(() => LoginControllerCubit(authRepository: sl()));
  sl.registerFactory(() => RegisterControllerCubit(authRepository: sl()));
  sl.registerFactory(() => ThemeModeCubit());

  //! REPOSITORIES
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authService: sl()));
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(todoService: sl()));

  //! SERVICES
  sl.registerLazySingleton<AuthService>(
      () => AuthServiceImpl(sharedPreferences: sl(), userDAO: sl()));
  sl.registerLazySingleton<TodoService>(
      () => TodoServiceImpl(sharedPreferences: sl(), todoDAO: sl()));

  //! DAO
  sl.registerLazySingleton<TodoDAO>(() => TodoDAOImpl());
  sl.registerLazySingleton<UserDAO>(() => UserDAOImpl());

  //! EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
