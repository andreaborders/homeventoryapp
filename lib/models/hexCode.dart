int hexCode(String colorHexCode) {
  colorHexCode = colorHexCode.replaceAll('#', '0xFF');
  return int.tryParse(colorHexCode) ?? 0xFFFFF;
}