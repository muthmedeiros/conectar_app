import 'package:cpf_cnpj_validator/cnpj_validator.dart';

typedef Validator = String? Function(String?);

class Validators {
  static Validator required([String label = 'Field']) =>
      (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null;

  static Validator minLen(int min, [String label = 'Field']) =>
      (v) => (v ?? '').trim().length < min ? '$label must be at least $min characters' : null;

  static Validator email([String label = 'Email']) => (v) {
    final s = (v ?? '').trim();
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s);
    return ok ? null : 'Enter a valid $label';
  };

  static Validator cnpj([String label = 'CNPJ']) => (v) {
    final s = (v ?? '').replaceAll(RegExp(r'\D'), '');
    final ok = CNPJValidator.isValid(s);
    return ok ? null : 'Enter a valid $label';
  };
}
