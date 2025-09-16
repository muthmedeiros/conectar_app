class UpdateClientDto {
  const UpdateClientDto({
    required this.corporateReason,
    required this.cnpj,
    required this.name,
    required this.status,
    required this.conectarPlus,
    required this.adminUserId,
  });

  final String corporateReason;
  final String cnpj;
  final String name;
  final String status;
  final bool conectarPlus;
  final String adminUserId;

  Map<String, dynamic> toMap() => {
        'corporateReason': corporateReason,
        'cnpj': cnpj,
        'name': name,
        'status': status,
        'conectarPlus': conectarPlus,
        'adminUserId': adminUserId,
      };
}
