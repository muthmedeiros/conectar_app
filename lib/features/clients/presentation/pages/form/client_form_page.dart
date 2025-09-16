// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/input_formatters/cnpj_input_formatter.dart';
import '../../../../../core/theme/tokens/tokens.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../domain/repositories/client_repository.dart';
import '../../controllers/client_form_controller.dart';

class ClientFormPage extends StatelessWidget {
  const ClientFormPage({super.key, this.clientId});

  final String? clientId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClientFormController>(
      create: (ctx) => ClientFormController(
        repo: sl<ClientRepository>(),
        auth: ctx.read<AuthController>(),
        clientId: clientId,
      )..init(),
      child: _ClientForm(),
    );
  }
}

class _ClientForm extends StatefulWidget {
  @override
  State<_ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<_ClientForm> {
  final _form = GlobalKey<FormState>();
  final _corporateReason = TextEditingController();
  final _cnpj = TextEditingController();
  final _name = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ClientFormController>();
      controller.fetchUsers();

      controller.addListener(() {
        if (controller.client != null) {
          final client = controller.client!;
          if (_corporateReason.text != client.corporateReason) {
            _corporateReason.text = client.corporateReason;
          }
          if (_cnpj.text != client.cnpj) {
            _cnpj.text = client.cnpj;
          }
          if (_name.text != client.name) {
            _name.text = client.name;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _corporateReason.dispose();
    _cnpj.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientFormController>();
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
                  onPressed: () => context.go('/home/clients'),
                ),
                const SizedBox(width: TSpacing.sm),
                Text(
                  isEdit ? 'Editar Cliente' : 'Novo Cliente',
                  style: TTypography.interSemiBold(fontSize: TFontSizes.xl),
                ),
              ],
            ),
            const SizedBox(height: TSpacing.xxl),
            TextFormField(
              controller: _corporateReason,
              decoration: const InputDecoration(labelText: 'Razão Social'),
              validator: Validators.required('Razão Social'),
            ),
            const SizedBox(height: TSpacing.md),
            TextFormField(
              controller: _cnpj,
              decoration: const InputDecoration(labelText: 'CNPJ'),
              validator: Validators.cnpj(),
              inputFormatters: [CnpjInputFormatter()],
            ),
            const SizedBox(height: TSpacing.md),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nome na Fachada'),
              validator: Validators.minLen(3, 'Nome na Fachada'),
            ),
            const SizedBox(height: TSpacing.md),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Status'),
              value: controller.status,
              items: const [
                DropdownMenuItem(value: 'active', child: Text('Ativo')),
                DropdownMenuItem(value: 'inactive', child: Text('Inativo')),
              ],
              onChanged: controller.updateStatus,
              validator: Validators.required('Status'),
            ),
            const SizedBox(height: TSpacing.md),
            DropdownButtonFormField<bool>(
              decoration: const InputDecoration(labelText: 'Conectar Plus'),
              value: controller.conectarPlus,
              items: const [
                DropdownMenuItem(value: true, child: Text('Sim')),
                DropdownMenuItem(value: false, child: Text('Não')),
              ],
              onChanged: controller.updateConectarPlus,
              validator: Validators.requiredDropdown<bool>('Conectar Plus'),
            ),
            const SizedBox(height: TSpacing.md),
            Visibility(
              visible: controller.loadingUsers,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: TSpacing.sm),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            Visibility(
              visible: !controller.loadingUsers,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Usuário Administrador'),
                value: controller.adminUserId,
                items: controller.users
                    .map((u) => DropdownMenuItem<String>(value: u.id, child: Text(u.name)))
                    .toList(),
                onChanged: controller.updateAdminUserId,
                validator: Validators.required('Usuário Administrador'),
              ),
            ),
            const SizedBox(height: TSpacing.md),
            Visibility(
              visible: controller.errorMsg != null,
              child: Text(
                controller.errorMsg ?? '',
                style: TTypography.interMedium(color: TColors.error, fontSize: TFontSizes.sm),
              ),
            ),
            const SizedBox(height: TSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.neutral0,
                      foregroundColor: TColors.errorDark,
                    ),
                    onPressed: controller.loading ? null : () => context.pop(false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: TSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: TColors.neutral0,
                    ),
                    onPressed: controller.loading
                        ? null
                        : () async {
                            if (!_form.currentState!.validate()) return;

                            final success = await controller.submit(
                              corporateReason: _corporateReason.text,
                              cnpj: _cnpj.text,
                              name: _name.text,
                            );

                            if (!mounted) return;

                            if (success) {
                              if (context.canPop()) {
                                context.pop(true);
                              } else {
                                context.go('/home/clients');
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
