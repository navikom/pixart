bool isEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}

Map authValidation = Map.fromIterables(
  ['email', 'password', 'confirmPassword'],
  [
    (String value) {
      if (!isEmail(value)) {
        return 'Email is not valid';
      }
      return null;
    },
    (String value) {
      if (value.length < 6) {
        return 'Password is too short, must be min 6 characters';
      }
      return null;
    },
    (String value, String pattern) {
      if (value != pattern) {
        return 'Confirm Password is not equal Password';
      }
      return null;
    }
  ],
);
