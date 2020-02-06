import 'package:http/http.dart';
import 'package:pixart/api/http_base.dart';

class ApiBase {
  int session;

  ApiBase(this.session);

  UsersMethods user() {
    return UsersMethods(this.session);
  }
}

class UsersMethods extends HTTPBase {
  UsersMethods(session) : super('users', session);

  signup(String email, String password) {
    Map body = Map.of(
      {'email': email, 'password': password, 'grantType': 'password'},
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

  refresh() {
    Map body = Map.fromIterables(['grantType'], ['refresh']);
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
