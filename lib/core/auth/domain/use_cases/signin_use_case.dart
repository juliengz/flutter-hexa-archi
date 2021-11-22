import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/errors.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_backend_gateway.dart';

class SigninUseCase {
  final AuthBackendGateway authBackendGateway;

  SigninUseCase({required this.authBackendGateway});

  Future<Either<AuthError, User>> call(String login, String password) async {
    return await authBackendGateway.signin(login, password);
  }
}
