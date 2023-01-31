class MyUser {
  static const String collectionNanme = 'users';

  String firstName;
  String lastName;
  String userName;
  String email;
  String id;

  MyUser(
      {required this.lastName,
      required this.firstName,
      required this.email,
      required this.id,
      required this.userName});

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          firstName: json['first_name'] as String,
          lastName: json['last_name'] as String,
          userName: json['user_name'] as String,
          id: json['id'] as String,
          email: json['email'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'email': email,
      'last_name': lastName,
      'user_name': lastName
    };
  }
}
