class LoginDomain {
  LoginDomain({
    this.username,
    this.password,
    this.firebase_id,
  });

  String? username;
  String? password;
  String? firebase_id = "Unknown";
}