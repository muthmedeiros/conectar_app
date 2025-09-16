import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/tokens/colors.dart';
import '../../../../core/theme/tokens/spacing.dart';
import '../../../../core/theme/tokens/typography.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/t_password_field.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/repositories/profile_repository.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProfileController(
        authController: ctx.read<AuthController>(),
        profileRepository: sl<ProfileRepository>(),
      ),
      child: const _ProfilePageBody(),
    );
  }
}

class _ProfilePageBody extends StatefulWidget {
  const _ProfilePageBody();

  @override
  State<_ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<_ProfilePageBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = context.read<AuthController>();
      final user = authController.user;

      if (user != null) {
        _setUserFields(user.name, user.email);
      }

      authController.addListener(() {
        final updatedUser = authController.user;
        if (updatedUser != null) {
          _setUserFields(updatedUser.name, updatedUser.email);
        }
      });
    });
  }

  void _setUserFields(String name, String email) {
    _nameController.text = name;
    _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final profileController = context.watch<ProfileController>();

    final user = authController.user;
    final isLoading = profileController.loading;
    final isSuccess = profileController.success;
    final errorMsg = profileController.errorMsg;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Scaffold(
          backgroundColor: TColors.neutral2,
          body: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isMobile ? double.maxFinite : 500),
                child: Padding(
                  padding: const EdgeInsets.all(TSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Editar perfil',
                        style: TTypography.interBold(fontSize: 28, color: TColors.neutral95),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: TSpacing.xl),
                      Visibility(
                        visible: isSuccess,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: TSpacing.lg),
                          child: Text(
                            'Perfil atualizado com sucesso!',
                            style: TTypography.interMedium(color: TColors.success, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: errorMsg != null,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: TSpacing.lg),
                          child: Text(
                            errorMsg ?? '',
                            style: TTypography.interMedium(color: TColors.tertiary, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nome',
                                border: OutlineInputBorder(),
                              ),
                              validator: Validators.required('Nome'),
                            ),
                            const SizedBox(height: TSpacing.lg),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                border: OutlineInputBorder(),
                              ),
                              validator: Validators.email(),
                            ),
                            const SizedBox(height: TSpacing.lg),
                            TPasswordField(
                              controller: _currentPasswordController,
                              label: 'Senha atual',
                              validator: Validators.required('Senha atual'),
                            ),
                            const SizedBox(height: TSpacing.lg),
                            TPasswordField(
                              controller: _newPasswordController,
                              label: 'Nova senha',
                              required: false,
                            ),
                            const SizedBox(height: TSpacing.lg),
                            DropdownButtonFormField<String>(
                              value: user?.role.value,
                              items: [
                                DropdownMenuItem(
                                  value: user?.role.value,
                                  child: Text(
                                    user?.role.value.toUpperCase() ?? '',
                                    style: TTypography.interMedium(color: TColors.neutral8),
                                  ),
                                ),
                              ],
                              onChanged: null,
                              decoration: const InputDecoration(
                                labelText: 'Tipo de usuário',
                                border: OutlineInputBorder(),
                              ),
                              disabledHint: Text(
                                user?.role.name ?? '',
                                style: TTypography.interRegular(color: TColors.neutral6),
                              ),
                            ),
                            const SizedBox(height: TSpacing.xl),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.primary,
                                  foregroundColor: TColors.neutral0,
                                  padding: const EdgeInsets.symmetric(vertical: TSpacing.md),
                                  textStyle: TTypography.interBold(fontSize: 16),
                                ),
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState?.validate() ?? false) {
                                          profileController.updateProfile(
                                            currentPassword: _currentPasswordController.text,
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            newPassword: _newPasswordController.text.isNotEmpty
                                                ? _newPasswordController.text
                                                : null,
                                          );
                                        }
                                      },
                                child: isLoading
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: TColors.neutral0,
                                        ),
                                      )
                                    : const Text('Salvar alterações'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
