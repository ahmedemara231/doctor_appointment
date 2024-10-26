class RegisterInputs {
  final String email;
  final String password;
  final String phone;

  RegisterInputs({required this.email, required this.password, required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phone': phone
    };
  }
}