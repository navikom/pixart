import 'dart:async';
import 'dart:io';

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
  static const String CONNECT_SID = "connectSid";

  final AppFlow app = locator<AppFlow>();
  final NavigationService _navigationService = locator<NavigationService>();
  BuildContext context;

  @observable
  bool anonymous = true;
  @observable
  String sid;
  @observable
  String connectSid;

  _Auth() {
    reaction((_) {
      return hasError;
    }, (bool isError) => isError ? showAlert() : null);
  }

  @action
  Future<void> refresh() async {
    try {
      this.update(await api().user().refresh());
    } on Exception catch (err) {
      print('Refresh ${err.toString()}');
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
      connectSid = prefs.getString(CONNECT_SID);
    });
    print('565656565566 $anonymous $connectSid');
    if (connectSid == null) {
      await loginAnonymous();
    } else {
      await refresh();
    }
  }

  @action
  void update(Map<String, dynamic> data) {
    anonymous = data['anonymous'];

    app.setUser(data['user']);
  }

  @action
  Future<void> setFromCookie(String cookie) async {
    List<String> lines = cookie.split(',');
    String newSid = Cookie.fromSetCookieValue(lines[0]).value;
    String connect = Cookie.fromSetCookieValue(lines[1]).value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CONNECT_SID, connect);
    runInAction(() {
      sid = newSid;
      connectSid = connect;
    });
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
