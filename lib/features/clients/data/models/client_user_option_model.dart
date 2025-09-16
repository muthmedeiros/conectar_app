import '../../domain/entities/client_user_option.dart';

class ClientUserOptionModel {
  static ClientUserOption fromMap(Map<String, dynamic> map) {
    return ClientUserOption(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
