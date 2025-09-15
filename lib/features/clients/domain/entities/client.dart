import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  const ClientEntity({
    required this.id,
    required this.name,
    required this.document,
    required this.ownerUserId,
  });

  final String id;
  final String name;
  final String document;
  final String ownerUserId;

  @override
  List<Object?> get props => [id, document, ownerUserId];
}
