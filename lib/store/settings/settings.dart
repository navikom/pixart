import 'package:mobx/mobx.dart';

part 'settings.g.dart';

class Settings = _Settings with _$Settings;

abstract class _Settings with Store {
  @observable
  bool silentMode = true;
  @observable
  int soundValue = 3;
  @observable
  String ringtone;
}
