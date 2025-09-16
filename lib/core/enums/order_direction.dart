enum OrderDirection {
  asc('ASC'),
  desc('DESC');

  const OrderDirection(this.value);
  final String value;

  String get label {
    switch (this) {
      case OrderDirection.asc:
        return 'Crescente';
      case OrderDirection.desc:
        return 'Decrescente';
    }
  }
}
