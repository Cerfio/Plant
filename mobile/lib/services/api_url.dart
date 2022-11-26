class ApiURL {
  static const String baseUrl = 'http://10.0.2.2:4242';

  static const String baseUrlEmbeeded = 'http://192.168.4.1';

  static const String signIn = '$baseUrl/auth/signin';
  static const String signUp = '$baseUrl/auth/signup';

  static const String networkScan = '$baseUrlEmbeeded/network/scan';
  static const String networkConnect = '$baseUrlEmbeeded/network/connect';

  static const String plant = '$baseUrl/plant';
}
