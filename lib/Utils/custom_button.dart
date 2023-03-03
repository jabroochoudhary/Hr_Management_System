import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final title;
  final double width;
  final double height;
  final Color txtcolor;
  final double txtsize;
  final Image;
  final TextAlign textAlign;
  final VoidCallback callback;
  final bool isimage;
  int padding;
  CustomButton({
    Key? key,
    this.title = "",
    this.width = 200,
    this.Image,
    this.isimage = false,
    this.height = 50,
    this.txtsize = 18,
    required this.callback,
    this.txtcolor = Colors.white,
    this.textAlign = TextAlign.start,
    this.padding = 0,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Container(
        // color: Color.fromRGBO(143, 148, 251, 1),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            // BoxShadow(
            //   color: Color.fromRGBO(143, 148, 251, .2),
            //   blurRadius: 20.0,
            //   offset: Offset(0, 10),
            // )
          ],
        ),
        child: Center(
          child: widget.isimage
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(widget.Image),
                    Text(
                      widget.title,
                      textAlign: widget.textAlign,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: widget.txtsize,
                        color: widget.txtcolor,
                      ),
                    ),
                  ],
                )
              : Text(
                  widget.title,
                  textAlign: widget.textAlign,
                  style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    fontSize: widget.txtsize,
                    color: widget.txtcolor,
                  ),
                ),
        ),
      ),
    );
  }
}

void callback() {
  callback();
}
