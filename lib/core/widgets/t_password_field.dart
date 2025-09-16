import 'package:flutter/material.dart';

import '../validation/validators.dart';

class TPasswordField extends StatefulWidget {
  const TPasswordField({super.key, this.controller, this.label, this.prefixIcon, this.onChanged});

  final TextEditingController? controller;
  final String? label;
  final IconData? prefixIcon;
  final Function(String)? onChanged;

  @override
  State<TPasswordField> createState() => _TPasswordFieldState();
}

class _TPasswordFieldState extends State<TPasswordField> {
  late final TextEditingController _passwordController;

  bool _obscure = true;

  @override
  void initState() {
    super.initState();

    _passwordController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      onChanged: widget.onChanged,
      obscureText: _obscure,
      decoration: InputDecoration(
        label: widget.label != null ? Text(widget.label!) : null,
        hintText: '**********',
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      validator: Validators.minLen(4, 'Senha'),
    );
  }
}
