// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Settings on _Settings, Store {
  final _$silentModeAtom = Atom(name: '_Settings.silentMode');

  @override
  bool get silentMode {
    _$silentModeAtom.context.enforceReadPolicy(_$silentModeAtom);
    _$silentModeAtom.reportObserved();
    return super.silentMode;
  }

  @override
  set silentMode(bool value) {
    _$silentModeAtom.context.conditionallyRunInAction(() {
      super.silentMode = value;
      _$silentModeAtom.reportChanged();
    }, _$silentModeAtom, name: '${_$silentModeAtom.name}_set');
  }

  final _$soundValueAtom = Atom(name: '_Settings.soundValue');

  @override
  int get soundValue {
    _$soundValueAtom.context.enforceReadPolicy(_$soundValueAtom);
    _$soundValueAtom.reportObserved();
    return super.soundValue;
  }

  @override
  set soundValue(int value) {
    _$soundValueAtom.context.conditionallyRunInAction(() {
      super.soundValue = value;
      _$soundValueAtom.reportChanged();
    }, _$soundValueAtom, name: '${_$soundValueAtom.name}_set');
  }

  final _$ringtoneAtom = Atom(name: '_Settings.ringtone');

  @override
  String get ringtone {
    _$ringtoneAtom.context.enforceReadPolicy(_$ringtoneAtom);
    _$ringtoneAtom.reportObserved();
    return super.ringtone;
  }

  @override
  set ringtone(String value) {
    _$ringtoneAtom.context.conditionallyRunInAction(() {
      super.ringtone = value;
      _$ringtoneAtom.reportChanged();
    }, _$ringtoneAtom, name: '${_$ringtoneAtom.name}_set');
  }
}
