import 'package:flutter/material.dart';

import '../theme/tokens/colors.dart';
import '../theme/tokens/font_sizes.dart';
import '../theme/tokens/spacing.dart';
import '../theme/tokens/typography.dart';

class TDataTable extends StatelessWidget {
  const TDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.columnSpacing = TSpacing.lg,
    this.border = const TableBorder.symmetric(
      inside: BorderSide(color: TColors.neutral3, width: 0.5),
    ),
    this.headingRowColor,
    this.dataRowColor,
    this.headingTextStyle,
    this.dataTextStyle,
  });

  final List<DataColumn> columns;
  final List<DataRow> rows;
  final double? columnSpacing;
  final TableBorder? border;
  final WidgetStateProperty<Color?>? headingRowColor;
  final WidgetStateProperty<Color?>? dataRowColor;
  final TextStyle? headingTextStyle;
  final TextStyle? dataTextStyle;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns,
      rows: rows,
      columnSpacing: columnSpacing,
      border: border,
      headingRowColor: headingRowColor ?? WidgetStateProperty.all(TColors.neutral2),
      dataRowColor: dataRowColor ?? WidgetStateProperty.all(TColors.neutral0),
      headingTextStyle:
          headingTextStyle ??
          TTypography.interBold(fontSize: TFontSizes.md, color: TColors.neutral9),
      dataTextStyle:
          dataTextStyle ??
          TTypography.interRegular(fontSize: TFontSizes.md, color: TColors.neutral7),
    );
  }
}
