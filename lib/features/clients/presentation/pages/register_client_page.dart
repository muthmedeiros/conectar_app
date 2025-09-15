// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/tokens/spacing.dart';
import '../../../../core/validation/validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/repositories/client_repository.dart';
import '../controllers/register_client_controller.dart';

class RegisterClientPage extends StatelessWidget {
  const RegisterClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterClientController>(
      create: (ctx) =>
          RegisterClientController(repo: sl<ClientRepository>(), auth: ctx.read<AuthController>()),
      child: const _RegisterClientForm(),
    );
  }
}

class _RegisterClientForm extends StatefulWidget {
  const _RegisterClientForm();

  @override
  State<_RegisterClientForm> createState() => _RegisterClientFormState();
}

class _RegisterClientFormState extends State<_RegisterClientForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _doc = TextEditingController();
  final _ownerUserId = TextEditingController(); // TODO: replace with dropdown

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterClientController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Register Client')),
      body: Padding(
        padding: EdgeInsets.all(TSpacing.md),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: Validators.required('Name'),
              ),
              SizedBox(height: TSpacing.sm),
              TextFormField(
                controller: _doc,
                decoration: const InputDecoration(labelText: 'Document'),
                validator: Validators.cnpj('Document'),
              ),
              SizedBox(height: TSpacing.sm),
              TextFormField(
                controller: _ownerUserId,
                decoration: const InputDecoration(labelText: 'Owner User ID'),
                validator: Validators.required('Owner User ID'),
              ),
              SizedBox(height: TSpacing.md),
              Visibility(
                visible: controller.errorMsg != null,
                child: Text(controller.errorMsg ?? '', style: const TextStyle(color: Colors.red)),
              ),
              SizedBox(height: TSpacing.sm),
              FilledButton(
                onPressed: controller.loading
                    ? null
                    : () async {
                        if (!_form.currentState!.validate()) return;
                        final ok = await controller.createClient(
                          name: _name.text.trim(),
                          document: _doc.text.trim(),
                          ownerUserId: _ownerUserId.text.trim(),
                        );
                        if (!mounted) return;
                        if (ok) Navigator.of(context).pop();
                      },
                child: controller.loading ? const CircularProgressIndicator() : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
