import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? userId;
  final String? name;
  final String email;
  final String? password;

  const User({
    this.userId,
    this.name,
    required this.email,
    this.password,
  });

  static const empty = User(email: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      //'token_expirated': isTokenExpirated
    };
  }

  User copyWith(
      {int? userId,
      String? name,
      String? email,
      String? password,
      bool? isTokenExpirated}) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      //isTokenExpirated: isTokenExpirated ?? this.isTokenExpirated
    );
  }

  @override
  List<Object?> get props => [userId, name, email, password];
}
