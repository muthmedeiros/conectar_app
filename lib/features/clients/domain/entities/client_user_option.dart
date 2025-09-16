import 'package:equatable/equatable.dart';

class ClientUserOption extends Equatable {
  const ClientUserOption({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
