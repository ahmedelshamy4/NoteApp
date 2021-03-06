class ValidarorsAuth {
  // * Email Validator
  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is empty';
    }
    if (!value.contains('@')) {
      return 'The email does not contain @';
    }
    if (!value.contains('.')) {
      return 'The email does not contain .';
    }
  }

  // * password Validator
  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'password is empty';
    }
    if (value.length < 7) {
      return 'password is less 7';
    }
  }
}
