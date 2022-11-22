String? validateWiFiPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Wi-Fi password cannot be empty';
  }
  return null;
}