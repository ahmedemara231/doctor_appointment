class RegisterInputs {
  final String email;
  final String name;
  final String password;
  final String passConfirmation;
  final String phone;

  final String gender;
  RegisterInputs({required this.email,
      required this.password,
      required this.phone,
      required this.passConfirmation,
      required this.name,
    required this.gender
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'gender': gender,
      'password_confirmation': passConfirmation
    };
  }
}
