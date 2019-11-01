import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pixart/api/api.dart';
import 'package:pixart/api/models.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/service/localization/localizations.dart';
import 'package:pixart/store/app_flow.dart';
import 'package:pixart/store/flow.dart' as f;
import 'package:pixart/store/requestable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pixart/widgets/dialog.dart' as dialog;

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth extends Requestable with Store, f.Flow {
  static const String REFRESH_TOKEN = "refresh_token";

  final AppFlow app = locator<AppFlow>();
  BuildContext context;

  @observable
  String token;
  @observable
  String refreshToken;
  @observable
  bool shouldFirstRefresh = false;
  @observable
  int expires;

  _Auth() {
    when((_) => shouldFirstRefresh, () => refresh());
    reaction((_) {
      return hasError;
    }, (bool isError) => isError ? showAlert() : null);
  }

  bool get isExpired => DateTime.now().millisecond > expires;

  @action
  Future<void> refresh() async {
    if (refreshToken == null) {
      return;
    }
    try {
      this.update(await nonAuthorizedApi().user().refresh(refreshToken));
    } catch (err) {
      print('Refresh Error ${err.message}');
      this.logout();
    }
  }

  @action
  Future<void> signup(String email, String password, void Function() successCb,
      void Function() failureCb) async {
    try {
      update(await api().user().signup(email, password));
      successCb();
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
    } catch (err) {
      setError(err.message);
      Timer(Duration(seconds: 2), failureCb);
    }
  }

  @action
  Future<void> loginAnonymous() async {
    try {
      update(await nonAuthorizedApi().user().anonymous());
    } catch (err) {
      print('Anonymous Error ${err.message}');
    }
  }

  @action
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await api().user().logout();
      prefs.remove(REFRESH_TOKEN);
      app.user.setAnonymous(true);
    } catch (err) {
      print('Logout Error ${err.message}');
    }
  }

  @action
  Future<void> checkLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    runInAction(() {
      refreshToken = prefs.getString(REFRESH_TOKEN);
      if (refreshToken != null) {
        shouldFirstRefresh = true;
      } else {
        loginAnonymous();
      }
    });
  }

  @action
  Future<void> update(LoginResultModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(REFRESH_TOKEN, data.refreshToken);
    runInAction(() {
      this.token = data.token;
      this.expires = data.expires * 1000;
      this.refreshToken = data.refreshToken;
    });
    app.setUser(data.user);
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
