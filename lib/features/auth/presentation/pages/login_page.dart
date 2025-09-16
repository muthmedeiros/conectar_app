// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/tokens/tokens.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/brand_logo.dart';
import '../../../../core/widgets/t_password_field.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'admin@conectar.com');
  final _passwordController = TextEditingController(text: 'admin123');

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        color: scheme.primary,
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: TSpacing.lg),
              const BrandLogo(tintColor: TColors.neutral0),
              const SizedBox(height: TSpacing.lg),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.md)),
                child: Padding(
                  padding: const EdgeInsets.all(TSpacing.lg),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Email', style: Theme.of(context).textTheme.labelMedium),
                        ),
                        const SizedBox(height: TSpacing.sm),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: 'email@dominio.com'),
                          validator: Validators.email('Email'),
                        ),
                        const SizedBox(height: TSpacing.sm + 4),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Senha', style: Theme.of(context).textTheme.labelMedium),
                        ),
                        const SizedBox(height: TSpacing.sm),
                        TPasswordField(controller: _passwordController),
                        const SizedBox(height: TSpacing.md),
                        Visibility(
                          visible: auth.errorMsg != null,
                          child: Text(
                            auth.errorMsg ?? '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(height: TSpacing.sm),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(TRadius.sm),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: TSpacing.md),
                              textStyle: Theme.of(context).textTheme.labelMedium,
                            ),
                            onPressed: auth.loading
                                ? null
                                : () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    final ok = await auth.login(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    );
                                    if (ok && mounted) context.go('/home');
                                  },
                            child: auth.loading
                                ? const CircularProgressIndicator()
                                : const Text('Entrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: TSpacing.xxxl),
            ],
          ),
        ),
      ),
    );
  }
}
