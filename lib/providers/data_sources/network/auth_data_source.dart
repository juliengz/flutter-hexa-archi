import 'package:flutter_clean_archi/core/auth/domain/entities/user.dart';
import 'package:flutter_clean_archi/core/auth/exceptions/bad_credential_exception.dart';
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
      },
    );

    return response;
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
      },
    );

    return response;
  }
}
