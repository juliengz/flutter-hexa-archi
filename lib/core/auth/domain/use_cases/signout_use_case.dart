import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/errors.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_backend_gateway.dart';

class SignoutUseCase {
  final AuthBackendGateway authBackendGateway;

  SignoutUseCase({required this.authBackendGateway});

  Future<Either<AuthError, bool>> call() async {
    return await authBackendGateway.signout();
  }
}
