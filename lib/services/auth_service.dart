import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dao/dao.dart';
import '../model/model.dart';

abstract class AuthService {
  Stream<User> get user;
  User get currentUser;
  Future<void> registerUser(User user);
  Future<void> login(User user);
  Future<void> loggout();
}

const userKey = 'USER_KEY';

class AuthServiceImpl implements AuthService {
  final SharedPreferences sharedPreferences;
  final UserDAO userDAO;

  AuthServiceImpl({required this.sharedPreferences, required this.userDAO}) {
    _init();
  }

  final _userStream = StreamController<User>.broadcast();

  _init() async {
    final user = _getUser();

    if (user != null) {
      _userStream.add(user);
      _userStream.stream.first;
    } else {
      _userStream.add(User.empty);
    }
  }

  @override
  Stream<User> get user => _userStream.stream;

  @override
  Future<void> login(User user) async {
    try {
      await _login(user);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  User get currentUser => _getUser() ?? User.empty;

  User? _getUser() {
    final jsonString = sharedPreferences.getString(userKey);

    if (jsonString != null) {
      return User.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }

  Future<void> _saveUser(User user) async {
    await sharedPreferences.setString(userKey, json.encode(user.toJson()));
  }

  @override
  Future<void> loggout() async {
    await sharedPreferences.remove(userKey);
  }

  @override
  Future<void> registerUser(User user) async {
    final response = await userDAO.addUser(user);
    if (response != 0) {
      try {
        _login(user);
      } on Exception catch (e) {
        throw Exception(e);
      }
    } else {
      throw Exception('Erro ao tentar cadastrar o usuário');
    }
  }

  Future<void> _login(User user) async {
    final response = await userDAO.getUserByEmail(user.email);
    if (response != null) {
      if (user.password == response.password) {
        _userStream.add(response);
        await _saveUser(response);
      } else {
        throw Exception('Senha inválida!');
      }
    } else {
      throw Exception('Usuário não cadastrado!');
    }
  }
}
