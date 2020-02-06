enum Gender { Male, Female }

abstract class UserModel {
  final int userId;
  final int createdOn;
  String email;
  int phone;
  String firstName;
  String lastName;
  DateTime birthday;
  Gender gender;
  bool notificationEmail;
  bool notificationSms;
  bool subscription;

  UserModel(this.userId, this.createdOn);
}

abstract class PictureModel {
  int pictureId;
  String path;
  int createdOn;
  String name;
  int categoryId;
}

abstract class LoginResultModel {
  String token;
  String refreshToken;
  int expires;
  UserModel user;
}
