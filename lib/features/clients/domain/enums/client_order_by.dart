enum ClientOrderBy {
  corporateReason('corporateReason'),
  name('name'),
  createdAt('createdAt');

  const ClientOrderBy(this.value);
  final String value;

  String get label {
    switch (this) {
      case ClientOrderBy.corporateReason:
        return 'Razão Social';
      case ClientOrderBy.name:
        return 'Nome';
      case ClientOrderBy.createdAt:
        return 'Data de Criação';
    }
  }
}
