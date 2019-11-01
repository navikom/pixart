import 'package:mobx/mobx.dart';
import 'package:pixart/api/models.dart';

part 'user.g.dart';

class User = _User with _$User;

abstract class _User with Store implements UserModel {
  final int userId;
  String email;
  final int createdOn;
  bool anonymous;
  int phone;
  DateTime birthday;
  Gender gender;
  bool notificationEmail;
  bool notificationSms;
  bool subscription;
  String firstName = "";
  String lastName = "";

  _User(this.userId, this.anonymous, this.createdOn);

  @action
  void setAnonymous(bool value) {
    anonymous = value;
  }

  @action
  void update(UserModel data) {
    this.email = data.email;
    this.anonymous = data.anonymous;
    this.phone = data.phone;
    this.firstName = data.firstName;
    this.lastName = data.lastName;
    this.birthday = data.birthday;
    this.gender = data.gender;
    this.notificationEmail = data.notificationEmail;
    this.notificationSms = data.notificationSms;
    this.subscription = data.subscription;
  }
}

User userFromData(UserModel data) {
  return User(data.userId, data.anonymous, data.createdOn);
}
