String? validateEmail(String? value) {
  String pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
  RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return 'First name cannot be empty';
  } else if (value.length < 2) {
    return 'First name must be at least 2 characters';
  }
  return null;
}

String? validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Last name cannot be empty';
  } else if (value.length < 2) {
    return 'Last name must be at least 2 characters';
  }
  return null;
}


String? validatePassword(String? value) {
  if (value == null || value.isEmpty || value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

String? validateConfirmPassword(String? src, String? dest) {
  if (src == null || src.isEmpty || src.length < 8 ) {
    return 'Password must be at least 8 characters';
  } else if (src != dest) {
    return 'Passwords do not match';
  }
  return null;
}
