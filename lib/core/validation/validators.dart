import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/widgets.dart';

typedef Validator = String? Function(String?);

class Validators {
  static Validator required([String label = 'Campo']) =>
      (v) => (v == null || v.trim().isEmpty) ? '$label é obrigatório' : null;

  static Validator minLen(int min, [String label = 'Campo']) =>
      (v) => (v ?? '').trim().length < min ? '$label deve ter pelo menos $min caracteres' : null;

  static Validator email([String label = 'E-mail']) => (v) {
    final s = (v ?? '').trim();
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s);
    return ok ? null : 'Informe um $label válido';
  };

  static Validator cnpj([String label = 'CNPJ']) => (v) {
    final s = (v ?? '').replaceAll(RegExp(r'\D'), '');
    final ok = CNPJValidator.isValid(s);
    return ok ? null : 'Informe um $label válido';
  };

  static FormFieldValidator<T> requiredDropdown<T>([String label = 'Campo']) =>
      (T? v) => v == null ? '$label é obrigatório' : null;
}
