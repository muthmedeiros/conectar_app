enum ClientStatus {
  active('active'),
  inactive('inactive');

  const ClientStatus(this.value);
  final String value;

  String get label {
    switch (this) {
      case ClientStatus.active:
        return 'Ativo';
      case ClientStatus.inactive:
        return 'Inativo';
    }
  }
}
