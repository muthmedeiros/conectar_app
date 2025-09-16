import 'package:flutter/material.dart';

import '../theme/tokens/spacing.dart';

class TCardList<T> extends StatelessWidget {
  const TCardList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.spacing = TSpacing.md,
    this.padding = const EdgeInsets.symmetric(horizontal: TSpacing.sm, vertical: TSpacing.xs),
  });

  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final double? spacing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: padding,
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: spacing),
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
