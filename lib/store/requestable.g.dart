// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Requestable on _Requestable, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError)).value;

  final _$errorAtom = Atom(name: '_Requestable.error');

  @override
  String get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$_RequestableActionController = ActionController(name: '_Requestable');

  @override
  void setError(String message) {
    final _$actionInfo = _$_RequestableActionController.startAction();
    try {
      return super.setError(message);
    } finally {
      _$_RequestableActionController.endAction(_$actionInfo);
    }
  }
}
