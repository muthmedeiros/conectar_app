import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTypography {
  static TextTheme lightTextTheme() =>
      GoogleFonts.interTextTheme(const TextTheme());

  static TextTheme darkTextTheme() =>
      GoogleFonts.interTextTheme(const TextTheme());

  static TextStyle interRegular({Color? color, double? fontSize}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: fontSize,
      );

  static TextStyle interMedium({Color? color, double? fontSize}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: color,
        fontSize: fontSize,
      );

  static TextStyle interSemiBold({Color? color, double? fontSize}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: color,
        fontSize: fontSize,
      );

  static TextStyle interBold({Color? color, double? fontSize}) =>
      GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: fontSize,
      );
}
