enum UserOrderBy {
  name('name'),
  createdAt('createdAt');

  const UserOrderBy(this.value);
  final String value;

  String get label {
    switch (this) {
      case UserOrderBy.name:
        return 'Nome';
      case UserOrderBy.createdAt:
        return 'Data de Criação';
    }
  }
}