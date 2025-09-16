class CreateUserDto {
  const CreateUserDto({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  final String name;
  final String email;
  final String password;
  final String role;

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      };
}