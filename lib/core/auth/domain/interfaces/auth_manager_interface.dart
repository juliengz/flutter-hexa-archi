import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';

abstract class AuthManagerInterface {
  Future<Either<Failure, dynamic>> signin(String login, String password);
  Future<void> signout();
  Future<void> handleAuthenticationState();
  bool isAuthenticated();
}
