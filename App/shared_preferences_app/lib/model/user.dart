class User {

  String userName = '';
  String password = '';
  String access = '';
  String color = '';
  String state = '';

  User({required this.userName, required this.password, required this.access, required this.state, required this.color});

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
      userName: object["userName"],
      password: object["password"],
      access: object["access"],
      color: object["color"],
      state: object["state"],
    );
  }
}