import 'package:flutter/cupertino.dart';

class TextView extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? line;
  final double? size;

  const TextView(
      {Key? key,
        this.color,
        this.fontWeight,
        required this.text,
        this.size,
        this.line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight,
            color: color,
            decoration: line));
  }
}