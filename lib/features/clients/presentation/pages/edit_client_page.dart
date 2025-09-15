// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/tokens/spacing.dart';
import '../../../../core/validation/validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/repositories/client_repository.dart';
import '../controllers/edit_client_controller.dart';

class EditClientPage extends StatelessWidget {
  const EditClientPage({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditClientController>(
      create: (ctx) =>
          EditClientController(repo: sl<ClientRepository>(), auth: ctx.read<AuthController>())
            ..load(clientId),
      child: _EditClientForm(clientId: clientId),
    );
  }
}

class _EditClientForm extends StatefulWidget {
  final String clientId;
  const _EditClientForm({required this.clientId});

  @override
  State<_EditClientForm> createState() => _EditClientFormState();
}

class _EditClientFormState extends State<_EditClientForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _doc = TextEditingController();
  final _ownerUserId = TextEditingController();
  bool _prefilled = false;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditClientController>();

    if (!_prefilled && controller.client != null) {
      _prefilled = true;
      _name.text = controller.client!.name;
      _doc.text = controller.client!.document;
      _ownerUserId.text = controller.client!.ownerUserId;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Edit Client #${widget.clientId}')),
      body: controller.loading && controller.client == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(TSpacing.md),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: Validators.required('Name'),
                      readOnly: !controller.canEdit,
                    ),
                    SizedBox(height: TSpacing.sm),
                    TextFormField(
                      controller: _doc,
                      decoration: const InputDecoration(labelText: 'Document'),
                      validator: Validators.cnpj('Document'),
                      readOnly: !controller.canEdit,
                    ),
                    SizedBox(height: TSpacing.sm),
                    TextFormField(
                      controller: _ownerUserId,
                      decoration: const InputDecoration(labelText: 'Owner User ID'),
                      readOnly: true,
                    ),
                    SizedBox(height: TSpacing.md),
                    Visibility(
                      visible: controller.errorMsg != null,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: TSpacing.sm),
                        child: Text(
                          controller.errorMsg ?? '',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.canEdit,
                      replacement: const Text('You don’t have permission to edit this client.'),
                      child: FilledButton(
                        onPressed: controller.loading
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) return;
                                final ok = await controller.update(
                                  name: _name.text.trim(),
                                  document: _doc.text.trim(),
                                );
                                if (!mounted) return;
                                if (ok) Navigator.of(context).pop();
                              },
                        child: controller.loading
                            ? const CircularProgressIndicator()
                            : const Text('Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
