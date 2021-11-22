import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/errors.dart';

abstract class AuthBackendGateway {
  Future<Either<AuthError, User>> signin(String login, String password);
  Future<Either<AuthError, bool>> signout();
  Future<Either<AuthError, User>> me();
}
