import 'package:flutter/material.dart';

import '../theme/tokens/tokens.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.height = TSpacing.xxxl, this.tintColor});

  final double height;
  final Color? tintColor;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'logos/conectar_logo.png',
      height: height,
      fit: BoxFit.contain,
      color: tintColor,
      colorBlendMode: tintColor == null ? null : BlendMode.srcIn,
      semanticLabel: 'Conéctar',
    );
  }
}
