class UpdateProfileDto {
  UpdateProfileDto({
    required this.currentPassword,
    this.name,
    this.email,
    this.newPassword,
  });

  final String currentPassword;
  final String? name;
  final String? email;
  final String? newPassword;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'currentPassword': currentPassword,
    };
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (newPassword != null && newPassword!.isNotEmpty) data['newPassword'] = newPassword;
    return data;
  }
}
