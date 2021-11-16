import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, dynamic>> signin(String login, String password);
  Future<Either<Failure, User>> getUser();
}
