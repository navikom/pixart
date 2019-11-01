import 'package:mobx/mobx.dart';
import 'package:pixart/api/models.dart';
import 'package:pixart/locator.dart';
import 'package:pixart/store/flow.dart';
import 'package:pixart/store/pictures/pictures.dart';
import 'package:pixart/store/user/user.dart';

part 'app_flow.g.dart';

class AppFlow = _AppFlow with _$AppFlow;

abstract class _AppFlow extends Flow with Store {
  final Pictures pictures = locator<Pictures>();
  @observable
  User user;

  @action
  void setUser(UserModel data) {
    if (this.user == null) {
      this.user = userFromData(data);
    } else {
      this.user.update(data);
    }
  }

  @override
  void start() {
    pictures.fetchItems();
  }

  @override
  void stop() {}

  @override
  String toString() {
    return '{"pictures": $pictures}';
  }
}
