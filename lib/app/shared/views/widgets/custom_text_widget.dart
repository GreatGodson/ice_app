import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.fontWeight,
      required this.color,
      required this.fontSize,
      required this.text,
      this.textAlign})
      : super(key: key);

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontFamily: 'Gordita',
      ),
    );
  }
}
