import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/api/api.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/service/localization/localizations.dart';
import 'package:pixart/service/navigation_service.dart';
import 'package:pixart/store/app_flow.dart';
import 'package:pixart/store/flow.dart' as f;
import 'package:pixart/store/requestable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pixart/widgets/dialog.dart' as dialog;
import 'package:pixart/constants/routes_path.dart' as constants;

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth extends Requestable with Store, f.Flow {
  static const String SESSION = "session";
  static const String ANONYMOUS = "anonymous";

  final AppFlow app = locator<AppFlow>();
  final NavigationService _navigationService = locator<NavigationService>();
  BuildContext context;

  @observable
  int session;
  @observable
  String refreshToken;
  @observable
  int expires;
  @observable
  bool anonymous = true;

  _Auth() {
    reaction((_) {
      return hasError;
    }, (bool isError) => isError ? showAlert() : null);
  }

  bool get isExpired => DateTime.now().millisecond > expires;

  @action
  Future<void> refresh() async {
    try {
      this.update(await api().user().refresh());
    } on Exception catch (err) {
      print('Refresh ${err.toString()}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(SESSION);
    }
  }

  @action
  Future<void> signup(String email, String password, void Function() successCb,
      void Function() failureCb) async {
    try {
      update(await api().user().signup(email, password));
      successCb();
      Timer(Duration(seconds: 1), () {
        _navigationService.navigateReplace(constants.SETTINGS_ROUTE);
      });
    } catch (err) {
      setError(err.message);
      Timer(Duration(seconds: 2), failureCb);
    }
  }

  @action
  Future<void> login(String email, String password, void Function() successCb,
      void Function() failureCb) async {
    try {
      update(await api().user().login(email, password));
      successCb();
      Timer(Duration(seconds: 1), () {
        _navigationService.navigateReplace(constants.SETTINGS_ROUTE);
      });
    } catch (err) {
      setError(err.message);
      Timer(Duration(seconds: 2), failureCb);
    }
  }

  @action
  Future<void> loginAnonymous() async {
    try {
      update(await api().user().anonymous());
    } on Exception catch (err) {
      print('Anonymous ${err.toString()}');
    }
  }

  @action
  Future<void> logout() async {
    try {
      await api().user().logout();
      runInAction(() {
        anonymous = true;
      });
    } on Exception catch (err) {
      print('Logout ${err.toString()}');
    }
  }

  @action
  Future<void> checkLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    runInAction(() {
      session = prefs.getInt(SESSION);
    });
    print('565656565566 $anonymous $session');
    if (session == null) {
      await loginAnonymous();
    } else {
      await refresh();
    }
  }

  @action
  Future<void> update(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(SESSION, data['session']);

    runInAction(() {
      session = data['session'];
      expires = data['expires'] * 1000;
      anonymous = data['anonymous'];
    });
    app.setUser(data['user']);
  }

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void showAlert() {
    if (context != null) {
      dialog.show(
        context,
        'Auth notification',
        Text(AppLocalizations.of(context).translate(error)),
        null,
      );
    }
    setError(null);
  }

  @action
  void start() {
    checkLocalStorage();
  }

  @action
  void stop() {}
}
