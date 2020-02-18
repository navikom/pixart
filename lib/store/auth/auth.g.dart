// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Auth on _Auth, Store {
  final _$anonymousAtom = Atom(name: '_Auth.anonymous');

  @override
  bool get anonymous {
    _$anonymousAtom.context.enforceReadPolicy(_$anonymousAtom);
    _$anonymousAtom.reportObserved();
    return super.anonymous;
  }

  @override
  set anonymous(bool value) {
    _$anonymousAtom.context.conditionallyRunInAction(() {
      super.anonymous = value;
      _$anonymousAtom.reportChanged();
    }, _$anonymousAtom, name: '${_$anonymousAtom.name}_set');
  }

  final _$sidAtom = Atom(name: '_Auth.sid');

  @override
  String get sid {
    _$sidAtom.context.enforceReadPolicy(_$sidAtom);
    _$sidAtom.reportObserved();
    return super.sid;
  }

  @override
  set sid(String value) {
    _$sidAtom.context.conditionallyRunInAction(() {
      super.sid = value;
      _$sidAtom.reportChanged();
    }, _$sidAtom, name: '${_$sidAtom.name}_set');
  }

  final _$connectSidAtom = Atom(name: '_Auth.connectSid');

  @override
  String get connectSid {
    _$connectSidAtom.context.enforceReadPolicy(_$connectSidAtom);
    _$connectSidAtom.reportObserved();
    return super.connectSid;
  }

  @override
  set connectSid(String value) {
    _$connectSidAtom.context.conditionallyRunInAction(() {
      super.connectSid = value;
      _$connectSidAtom.reportChanged();
    }, _$connectSidAtom, name: '${_$connectSidAtom.name}_set');
  }

  final _$refreshAsyncAction = AsyncAction('refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$signupAsyncAction = AsyncAction('signup');

  @override
  Future<void> signup(String email, String password, void Function() successCb,
      void Function() failureCb) {
    return _$signupAsyncAction
        .run(() => super.signup(email, password, successCb, failureCb));
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<void> login(String email, String password, void Function() successCb,
      void Function() failureCb) {
    return _$loginAsyncAction
        .run(() => super.login(email, password, successCb, failureCb));
  }

  final _$loginAnonymousAsyncAction = AsyncAction('loginAnonymous');

  @override
  Future<void> loginAnonymous() {
    return _$loginAnonymousAsyncAction.run(() => super.loginAnonymous());
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$checkLocalStorageAsyncAction = AsyncAction('checkLocalStorage');

  @override
  Future<void> checkLocalStorage() {
    return _$checkLocalStorageAsyncAction.run(() => super.checkLocalStorage());
  }

  final _$setFromCookieAsyncAction = AsyncAction('setFromCookie');

  @override
  Future<void> setFromCookie(String cookie) {
    return _$setFromCookieAsyncAction.run(() => super.setFromCookie(cookie));
  }

  final _$_AuthActionController = ActionController(name: '_Auth');

  @override
  void update(Map<String, dynamic> data) {
    final _$actionInfo = _$_AuthActionController.startAction();
    try {
      return super.update(data);
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  void start() {
    final _$actionInfo = _$_AuthActionController.startAction();
    try {
      return super.start();
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stop() {
    final _$actionInfo = _$_AuthActionController.startAction();
    try {
      return super.stop();
    } finally {
      _$_AuthActionController.endAction(_$actionInfo);
    }
  }
}
