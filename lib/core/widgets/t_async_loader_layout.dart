import 'package:flutter/material.dart';

import '../theme/tokens/colors.dart';
import '../theme/tokens/font_sizes.dart';
import '../theme/tokens/spacing.dart';
import '../theme/tokens/typography.dart';

class TAsyncLoaderLayout extends StatelessWidget {
  const TAsyncLoaderLayout({
    super.key,
    required this.child,
    required this.itemsCount,
    required this.isLoading,
    required this.errorMsg,
    required this.refresh,
    required this.label,
    required this.icon,
  });

  final Widget child;
  final bool isLoading;
  final String? errorMsg;
  final Function()? refresh;
  final int itemsCount;
  final String label;
  final IconData icon;

  String get _labelText => label.toLowerCase();

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMsg != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: TColors.error),
            const SizedBox(height: TSpacing.md),
            Text(
              'Erro ao carregar $_labelText',
              style: TTypography.interSemiBold(color: TColors.neutral100, fontSize: TFontSizes.lg),
            ),
            const SizedBox(height: TSpacing.sm),
            Text(
              errorMsg!,
              style: TTypography.interRegular(color: TColors.neutral6, fontSize: TFontSizes.md),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSpacing.lg),
            ElevatedButton.icon(
              onPressed: refresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (itemsCount == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: TColors.neutral6),
            const SizedBox(height: TSpacing.md),
            Text(
              'Nenhum $_labelText encontrado',
              style: TTypography.interSemiBold(color: TColors.neutral100, fontSize: TFontSizes.lg),
            ),
            const SizedBox(height: TSpacing.sm),
            Text(
              'Tente ajustar os filtros ou criar um novo $_labelText',
              style: TTypography.interRegular(color: TColors.neutral6, fontSize: TFontSizes.md),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return child;
  }
}
