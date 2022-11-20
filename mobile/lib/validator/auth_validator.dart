String? validateEmail(String? value) {
  String pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";

  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}
