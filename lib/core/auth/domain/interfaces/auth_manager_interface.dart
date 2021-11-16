import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';

abstract class AuthenticationManagerInterface {
  Future<Either<Failure, dynamic>> signin(String login, String password);
  Future<void> signout();
  bool isAuthenticated();
  Future<void> handleAuthenticationState();
}
