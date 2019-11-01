import 'package:pixart/api/api_base.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/auth/auth.dart';
import 'package:pixart/utils/error_handler.dart';

ApiBase api() {
  Auth auth = locator<Auth>();
  if (auth.token == null) throw ErrorHandler("Token is null");
  return ApiBase(auth.token);
}

ApiBase nonAuthorizedApi() {
  return ApiBase(null);
}
