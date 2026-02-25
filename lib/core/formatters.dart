import 'package:flutter/services.dart';

/// Транслитерация кириллицы в латиницу (логины, файлы).
String transliterate(String text) {
  const cyrillic =
      'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя';
  const latin = [
    'A', 'B', 'V', 'G', 'D', 'E', 'E', 'ZH', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N',
    'O', 'P', 'R', 'S', 'T', 'U', 'F', 'H', 'TS', 'CH', 'SH', 'SCH', '', 'Y', '',
    'E', 'YU', 'YA',
    'a', 'b', 'v', 'g', 'd', 'e', 'e', 'zh', 'z', 'i', 'y', 'k', 'l', 'm', 'n',
    'o', 'p', 'r', 's', 't', 'u', 'f', 'h', 'ts', 'ch', 'sh', 'sch', '', 'y', '',
    'e', 'yu', 'ya',
  ];
  final buffer = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    final index = cyrillic.indexOf(text[i]);
    if (index >= 0) {
      buffer.write(latin[index]);
    } else {
      buffer.write(text[i]);
    }
  }
  return buffer.toString();
}

/// Форматтер поля телефона: +7 (XXX) XXX-XX-XX.
class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    if (text.isNotEmpty) {
      formatted = '+7 ';
      if (text.length > 1) {
        formatted += '(${text.substring(1, text.length >= 4 ? 4 : text.length)}';
      }
      if (text.length >= 4) {
        formatted += ') ${text.substring(4, text.length >= 7 ? 7 : text.length)}';
      }
      if (text.length >= 7) {
        formatted += '-${text.substring(7, text.length >= 9 ? 9 : text.length)}';
      }
      if (text.length >= 9) {
        formatted += '-${text.substring(9, text.length >= 11 ? 11 : text.length)}';
      }
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
