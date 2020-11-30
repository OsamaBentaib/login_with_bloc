class UserSignUp {
  String username;
  String password1;
  String password2;
  String email;

  UserSignUp({this.username, this.password1, this.password2, this.email});

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "password1": this.password1,
    "password2": this.password2,
    "email": this.email
  };
}

class Token{
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}