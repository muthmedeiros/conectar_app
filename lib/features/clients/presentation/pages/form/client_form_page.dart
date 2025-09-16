// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/input_formatters/cnpj_input_formatter.dart';
import '../../../../../core/theme/tokens/colors.dart';
import '../../../../../core/theme/tokens/font_sizes.dart';
import '../../../../../core/theme/tokens/spacing.dart';
import '../../../../../core/theme/tokens/typography.dart';
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
      ),
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = context.read<ClientFormController>();
      controller.fetchUsers();

      if (controller.isEdit) {
        await controller.fetchClientById();

        final client = controller.client;

        if (client != null) {
          _corporateReason.text = client.corporateReason;
          _cnpj.text = client.cnpj;
          _name.text = client.name;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientFormController>();
    final isEdit = controller.isEdit;

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
            const SizedBox(height: TSpacing.sm),
            TextFormField(
              controller: _cnpj,
              decoration: const InputDecoration(labelText: 'CNPJ'),
              validator: Validators.cnpj(),
              inputFormatters: [CnpjInputFormatter()],
            ),
            const SizedBox(height: TSpacing.sm),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nome na Fachada'),
              validator: Validators.minLen(3, 'Nome na Fachada'),
            ),
            const SizedBox(height: TSpacing.sm),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Status'),
              value: controller.status,
              items: const [
                DropdownMenuItem(value: 'active', child: Text('Ativo')),
                DropdownMenuItem(value: 'inactive', child: Text('Inativo')),
                DropdownMenuItem(value: 'pending', child: Text('Pendente')),
              ],
              onChanged: controller.updateStatus,
              validator: Validators.required('Status'),
            ),
            const SizedBox(height: TSpacing.sm),
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
            const SizedBox(height: TSpacing.sm),
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
            FilledButton(
              onPressed: controller.loading
                  ? null
                  : () async {
                      if (!_form.currentState!.validate()) return;

                      final ok = await controller.submit(
                        corporateReason: _corporateReason.text,
                        cnpj: _cnpj.text,
                        name: _name.text,
                      );

                      if (!mounted) return;

                      if (ok) {
                        if (context.canPop()) {
                          context.pop(true);
                        } else {
                          context.go('/home/clients');
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cliente criado com sucesso!')),
                        );
                      }
                    },
              child: controller.loading
                  ? const CircularProgressIndicator()
                  : Text(isEdit ? 'Salvar Alterações' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
