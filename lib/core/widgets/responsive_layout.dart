import 'package:flutter/widgets.dart';

enum AppBreakpoint { mobile, desktop }

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
    this.desktopMinWidth = 800,
  });

  final Widget mobile;
  final Widget desktop;
  final double desktopMinWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) => c.maxWidth >= desktopMinWidth ? desktop : mobile);
  }
}
