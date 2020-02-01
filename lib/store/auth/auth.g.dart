// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Auth on _Auth, Store {
  final _$tokenAtom = Atom(name: '_Auth.token');

  @override
  String get token {
    _$tokenAtom.context.enforceReadPolicy(_$tokenAtom);
    _$tokenAtom.reportObserved();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.context.conditionallyRunInAction(() {
      super.token = value;
      _$tokenAtom.reportChanged();
    }, _$tokenAtom, name: '${_$tokenAtom.name}_set');
  }

  final _$refreshTokenAtom = Atom(name: '_Auth.refreshToken');

  @override
  String get refreshToken {
    _$refreshTokenAtom.context.enforceReadPolicy(_$refreshTokenAtom);
    _$refreshTokenAtom.reportObserved();
    return super.refreshToken;
  }

  @override
  set refreshToken(String value) {
    _$refreshTokenAtom.context.conditionallyRunInAction(() {
      super.refreshToken = value;
      _$refreshTokenAtom.reportChanged();
    }, _$refreshTokenAtom, name: '${_$refreshTokenAtom.name}_set');
  }

  final _$shouldFirstRefreshAtom = Atom(name: '_Auth.shouldFirstRefresh');

  @override
  bool get shouldFirstRefresh {
    _$shouldFirstRefreshAtom.context
        .enforceReadPolicy(_$shouldFirstRefreshAtom);
    _$shouldFirstRefreshAtom.reportObserved();
    return super.shouldFirstRefresh;
  }

  @override
  set shouldFirstRefresh(bool value) {
    _$shouldFirstRefreshAtom.context.conditionallyRunInAction(() {
      super.shouldFirstRefresh = value;
      _$shouldFirstRefreshAtom.reportChanged();
    }, _$shouldFirstRefreshAtom, name: '${_$shouldFirstRefreshAtom.name}_set');
  }

  final _$expiresAtom = Atom(name: '_Auth.expires');

  @override
  int get expires {
    _$expiresAtom.context.enforceReadPolicy(_$expiresAtom);
    _$expiresAtom.reportObserved();
    return super.expires;
  }

  @override
  set expires(int value) {
    _$expiresAtom.context.conditionallyRunInAction(() {
      super.expires = value;
      _$expiresAtom.reportChanged();
    }, _$expiresAtom, name: '${_$expiresAtom.name}_set');
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

  final _$updateAsyncAction = AsyncAction('update');

  @override
  Future<void> update(Map<String, dynamic> data) {
    return _$updateAsyncAction.run(() => super.update(data));
  }

  final _$_AuthActionController = ActionController(name: '_Auth');

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
