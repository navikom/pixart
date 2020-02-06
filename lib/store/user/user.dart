import 'package:mobx/mobx.dart';
import 'package:pixart/api/models.dart';

part 'user.g.dart';

class User = _User with _$User;

abstract class _User with Store implements UserModel {
  final int userId;
  String email;
  final int createdOn;
  int phone;
  DateTime birthday;
  Gender gender;
  bool notificationEmail;
  bool notificationSms;
  bool subscription;
  String firstName = "";
  String lastName = "";

  _User(this.userId, this.createdOn);

  @action
  void update(Map<String, dynamic> data) {
    this.email = data['email'];
    this.phone = data['phone'];
    this.firstName = data['firstName'];
    this.lastName = data['lastName'];
    this.birthday = data['birthday'];
    this.gender = data['gender'];
    this.notificationEmail = data['notificationEmail'];
    this.notificationSms = data['notificationSms'];
    this.subscription = data['subscription'];
  }
}

User userFromData(Map<String, dynamic> data) {
  return User(data['userId'], data['createdOn']);
}
