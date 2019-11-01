import 'package:http/http.dart';
import 'package:pixart/api/http_base.dart';

class ApiBase {
  String token;

  ApiBase(this.token);

  UsersMethods user() {
    return UsersMethods();
  }
}

class UsersMethods extends HTTPBase {
  UsersMethods() : super('users');

  signup(String email, String password) {
    Map body = Map.of(
      {email: email, password: password, 'grantType': 'password'},
    );
    return fetch('post', 'sign-up', body);
  }

  login(String email, String password) {
    Map body = Map.fromIterables(
        ['email', 'password', 'grantType'], [email, password, 'password']);
    return fetch('post', 'login', body);
  }

  anonymous() {
    return fetch('post', 'anonymous');
  }

  refresh(String refreshToken) {
    Map body = Map.fromIterables(
        ['token', 'grantType'], [refreshToken, 'refresh_token']);
    return fetch('post', 'login', body);
  }

  logout() {
    return fetch('get', 'logout');
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return null;
  }
}
