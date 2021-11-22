import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/failure.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_repository_interface.dart';
import 'package:flutter_clean_archi/providers/data_sources/exceptions/bad_credential_exception.dart';
import 'package:flutter_clean_archi/providers/data_sources/exceptions/forbidden_exception.dart';
import 'package:flutter_clean_archi/providers/data_sources/network/auth_data_source.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> signin(
      String login, String password) async {
    try {
      return Right(await authDataSource.signin(login, password));
    } on BadCredentialException {
      return Left(BadCredentialFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      return Right(await authDataSource.getUser());
    } on BadCredentialException {
      return Left(BadCredentialFailure());
    } on ForbiddenException {
      return Left(ForbiddenFailure());
    }
  }
}
