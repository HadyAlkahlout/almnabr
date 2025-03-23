import 'package:flutter/material.dart';

class ColorManager {

  static Color primary = HexColor.fromHex('#283181');
  static Color primaryOpacity70 = HexColor.fromHex("#B3283181");
  static Color primaryOpacity15 = HexColor.fromHex("#26283181");
  static Color accent = HexColor.fromHex('#1B92BC');
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color grey = HexColor.fromHex('#737477');
  static Color lightGrey = HexColor.fromHex('#E2E2E2');
  static Color selectColor = HexColor.fromHex('#F3F6F6');
  static Color black = HexColor.fromHex("#000000");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color success = HexColor.fromHex("#02d113");
  static Color successOpacity15 = HexColor.fromHex("#09d402");
  static Color error = HexColor.fromHex("#DB0000");
  static Color errorOpacity15 = HexColor.fromHex("#c71602");
  static Color cardStartColor = HexColor.fromHex("#EDEFFF");
  static Color cardEndColor = HexColor.fromHex("#34AFB9C8");
  static Color approvedColor = HexColor.fromHex("#D3F1DF");
  static Color rejectedColor = HexColor.fromHex("#FFB0B0");

}

extension HexColor on Color {
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length == 6){
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}