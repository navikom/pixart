import 'package:mobx/mobx.dart';

part 'requestable.g.dart';

class Requestable = _Requestable with _$Requestable;

abstract class _Requestable with Store {
  @observable
  String error;

  @computed
  bool get hasError => error != null;

  @action
  void setError(String message) {
    error = message;
  }
}
