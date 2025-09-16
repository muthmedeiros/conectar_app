// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/enums/user_role.dart';
import '../../../../../core/theme/tokens/tokens.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../controllers/user_form_controller.dart';

class UserFormPage extends StatelessWidget {
  const UserFormPage({super.key, this.userId});

  final String? userId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserFormController>(
      create: (ctx) => UserFormController(
        repo: sl<UserRepository>(),
        auth: ctx.read<AuthController>(),
        userId: userId,
      )..init(),
      child: _UserForm(),
    );
  }
}

class _UserForm extends StatefulWidget {
  @override
  State<_UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<_UserForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<UserFormController>();

      // Update controllers when user data is loaded
      controller.addListener(() {
        if (controller.name != null && _name.text != controller.name) {
          _name.text = controller.name!;
        }
        if (controller.email != null && _email.text != controller.email) {
          _email.text = controller.email!;
        }
      });
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserFormController>();
    final isEdit = controller.isEdit;

    if (controller.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Padding(
      padding: const EdgeInsets.all(TSpacing.xxxl),

      child: Form(
        key: _form,
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/home/users'),
                ),
                const SizedBox(width: TSpacing.sm),
                Text(
                  isEdit ? 'Editar Cliente' : 'Novo Cliente',
                  style: TTypography.interSemiBold(fontSize: TFontSizes.xl),
                ),
              ],
            ),
            const SizedBox(height: TSpacing.xxl),
            const SizedBox(height: TSpacing.lg),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
              ),
              validator: Validators.required('Nome'),
              onChanged: controller.updateName,
            ),
            const SizedBox(height: TSpacing.md),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              validator: Validators.email(),
              keyboardType: TextInputType.emailAddress,
              onChanged: controller.updateEmail,
            ),
            if (!isEdit) ...[
              const SizedBox(height: TSpacing.md),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: Validators.required('Senha'),
                obscureText: true,
                onChanged: controller.updatePassword,
              ),
            ],
            const SizedBox(height: TSpacing.md),
            DropdownButtonFormField<UserRole>(
              value: controller.role,
              decoration: const InputDecoration(
                labelText: 'Perfil',
                prefixIcon: Icon(Icons.admin_panel_settings),
              ),
              validator: (value) =>
                  value == null ? 'Perfil é obrigatório' : null,
              items: UserRole.values.map((role) {
                return DropdownMenuItem<UserRole>(
                  value: role,
                  child: Text(role.name.toUpperCase()),
                );
              }).toList(),
              onChanged: controller.updateRole,
            ),
            const SizedBox(height: TSpacing.md),
            Visibility(
              visible: controller.errorMsg != null,
              child: Text(
                controller.errorMsg ?? '',
                style: TTypography.interMedium(
                  color: TColors.error,
                  fontSize: TFontSizes.sm,
                ),
              ),
            ),
            const SizedBox(height: TSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.loading
                        ? null
                        : () => context.pop(false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: TSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.loading
                        ? null
                        : () async {
                            if (!_form.currentState!.validate()) return;

                            final success = await controller.save();

                            if (!mounted) return;

                            if (success) {
                              if (context.canPop()) {
                                context.pop(true);
                              } else {
                                context.go('/home/users');
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(controller.successMsg!),
                                  backgroundColor: TColors.primary,
                                ),
                              );
                            }
                          },
                    child: controller.loading
                        ? const CircularProgressIndicator()
                        : Text(isEdit ? 'Atualizar' : 'Criar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
