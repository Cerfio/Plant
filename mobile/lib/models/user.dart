class User {
  String userId;
  String firstName;
  String lastName;
  String email;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      firstName: responseData['firstname'],
      lastName: responseData['lastname'],
      email: responseData['email'],
    );
  }
}
