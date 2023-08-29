import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHexa("#ED9728");
  static Color darkGrey = HexColor.fromHexa("#525252");
  static Color grey = HexColor.fromHexa("#737477");
  static Color lightGrey = HexColor.fromHexa("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHexa("#B3ED9728");
}

extension HexColor on Color {
  ///
  /// Method to convert the hexa colors string into  a [Color] object
  ///
  /// Because hexa colors can come with or without opacity we need to
  /// 1. validate over the length of the coming hexa
  /// 2. convert it into a parsable string by removing the "#" and adding
  /// the opacity values
  /// 3. return the color of the integer of the parsed string
  ///
  /// #### Note:
  /// To parse a hexa string into an integer u need to specify the [radix]
  /// param `int.parse('hexaString', radix: 16)`
  /// but by prefixing the string with "0x" the constructor knows its a hexa int
  /// what u want
  ///
  static Color fromHexa(String hexaColor) {
    String readyToParseString;
    if (hexaColor.length == 6) {
      readyToParseString = hexaColor.replaceAll('#', '0xFF');
    } else {
      readyToParseString = hexaColor.replaceAll('#', '0x');
    }
    return Color(int.parse(readyToParseString));
  }
}
