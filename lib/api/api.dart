import 'package:pixart/api/api_base.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/auth/auth.dart';

ApiBase api() {
  Auth auth = locator<Auth>();
  return ApiBase(auth.session);
}
