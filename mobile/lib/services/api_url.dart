class ApiURL {
  static const String baseUrl =
      'http://9206-2a01-cb08-55a-2500-2d7b-6238-e3a2-6ae.ngrok.io';

  static const String baseUrlEmbeeded = 'http://192.168.4.1';

  static const String signIn = '$baseUrl/auth/signin';
  static const String signUp = '$baseUrl/auth/signup';

  static const String networkScan = '$baseUrlEmbeeded/network/scan';
  static const String networkConnect = '$baseUrlEmbeeded/network/connect';

  static const String plant = '$baseUrl/plant';
}
