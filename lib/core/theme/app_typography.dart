import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // حتماً این خط را چک کن که غلط املایی نداشته باشد

class AppTypography {
  // استایل مخصوص تیترها با تم مدرن
  static TextStyle get headerStyle => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      );

  // استایل بدنه با آیکون مجازی (برای راهنمایی در کد)
  // 🖋️ Use for standard descriptions
  static TextStyle get bodyStyle => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
}