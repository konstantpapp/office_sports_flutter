class ValidationMixin {
  String? validateNickname(String? value) {
    if (value!.contains(' ')) {
      return "Nickname cannot have whitespaces";
    }
    if (value.length < 3) {
      return 'Nickname must be at least 3 characters';
    }
    return null;
  }
}
