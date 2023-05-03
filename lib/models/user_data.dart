class User {
  String userName;
  String email;
  String password;

  User(this.userName, this.email, this.password);
}

enum AuthMode { Login, SignUp }
