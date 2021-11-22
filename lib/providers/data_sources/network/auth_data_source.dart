import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/providers/data_sources/exceptions/bad_credential_exception.dart';
import 'package:flutter_clean_archi/providers/data_sources/exceptions/forbidden_exception.dart';
import 'package:flutter_clean_archi/providers/http_client/http_request.dart';

class AuthDataSource {
  Future<Map<String, dynamic>> signin(String login, String password) async {
    var response = await HttpRequest(
        path: 'auth', data: {'login': login, 'password': password}).post(
      onSuccess: (response) {
        Map mappedResponse = response.data;
        return {
          "accessToken": mappedResponse['accessToken'],
          "refreshToken": mappedResponse['refreshToken'],
        };
      },
      onError: (error) {
        if (error.response?.statusCode == 401) {
          throw BadCredentialException();
        }
        if (error.response?.statusCode == 403) {
          throw ForbiddenException();
        }
      },
    );

    return (response != Null) ? response : Null;
  }

  Future<User> getUser() async {
    var response = await HttpRequest(path: 'me').get(
      onSuccess: (response) {
        return User.fromJson(response.data);
      },
      onError: (error) {
        if (error.response?.statusCode == 401) {
          throw BadCredentialException();
        }
        if (error.response?.statusCode == 403) {
          throw ForbiddenException();
        }
      },
    );

    return response;
  }
}
