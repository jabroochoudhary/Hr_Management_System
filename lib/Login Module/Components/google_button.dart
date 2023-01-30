import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_management_system/Utils/colors.dart';

class GoogleButton extends StatefulWidget {
  final title;
  final double width;
  final double height;
  final VoidCallback callback;
  GoogleButton({
    Key? key,
    this.title = "",
    this.width= 200,
    this.height= 50,
    required this.callback,
  }) : super(key: key);

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}
class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.callback,
      child: Container(
        // color: Color.fromRGBO(143, 148, 251, 1),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: AppColors.textbox,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: AppColors.textbox,
                  blurRadius: 5.0,
                  offset: Offset(0, 2)
              )
            ]
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/google_logo.png",width: 40,),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.textlight,

                ),

              ),
            ],
          )
        ),
      ),
    );
  }
}

void callback() {
  callback();
}