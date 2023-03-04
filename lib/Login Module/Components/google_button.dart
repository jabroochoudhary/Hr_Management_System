import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
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
    this.width = 200,
    this.height = 50,
    required this.callback,
  }) : super(key: key);

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,

      // text: widget.title,
      // shape: Border.all(
      //   // color: AppColors.primarycolor,
      //   width: 0.5,
      //   style: BorderStyle.solid,
      // ),
      // text: "Sign up with Google",
      onPressed: widget.callback,
    );
  }
}

void callback() {
  callback();
}
