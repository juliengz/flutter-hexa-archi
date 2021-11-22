import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/domain/errors/errors.dart';
import 'package:flutter_clean_archi/core/auth/domain/interfaces/auth_backend_gateway.dart';
import 'package:flutter_clean_archi/providers/http_client/http_request.dart';
import 'package:get_storage/get_storage.dart';

class HttpAuthBackendGateway implements AuthBackendGateway {
  final box = GetStorage();

  @override
  Future<Either<AuthError, User>> signin(String login, String password) async {
    Either<AuthError, User> response = await HttpRequest(
        path: 'auth', data: {'login': login, 'password': password}).post(
      onSuccess: (response) async {
        Map mappedResponse = response.data;

        await box.write('accessToken', mappedResponse['accessToken']);
        await box.write('refreshToken', mappedResponse['refreshToken']);

        return me();
      },
      onError: (error) {
        if (error.response?.statusCode == 401) {
          Either<AuthError, User> result = Left(BadCredentialError());
          return result;
        }
        if (error.response?.statusCode == 403) {
          Either<AuthError, User> result = Left(ForbiddenError());
          return result;
        }
      },
    );

    return response;
  }

  @override
  Future<Either<AuthError, bool>> signout() async {
    return const Right(true);
  }

  @override
  Future<Either<AuthError, User>> me() async {
    Either<AuthError, User> response = await HttpRequest(path: 'me').get(
      onSuccess: (response) {
        Either<AuthError, User> result = Right(User.fromJson(response.data));
        return result;
      },
      onError: (error) {
        if (error.response?.statusCode == 401) {
          Either<AuthError, User> result = Left(BadCredentialError());
          return result;
        }
        if (error.response?.statusCode == 403) {
          Either<AuthError, User> result = Left(ForbiddenError());
          return result;
        }
      },
    );

    return response;
  }
}
