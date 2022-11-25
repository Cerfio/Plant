class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  String token;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      firstName: responseData['firstName'],
      lastName: responseData['lastName'],
      email: responseData['email'],
      token: responseData['access_token'],
    );
  }
}
