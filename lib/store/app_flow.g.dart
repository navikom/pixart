// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_flow.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppFlow on _AppFlow, Store {
  final _$userAtom = Atom(name: '_AppFlow.user');

  @override
  User get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$_AppFlowActionController = ActionController(name: '_AppFlow');

  @override
  void setUser(Map<String, dynamic> data) {
    final _$actionInfo = _$_AppFlowActionController.startAction();
    try {
      return super.setUser(data);
    } finally {
      _$_AppFlowActionController.endAction(_$actionInfo);
    }
  }
}
