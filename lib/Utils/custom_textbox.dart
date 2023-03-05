import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_management_system/Utils/colors.dart';

class CustomTextbox extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final bool isPassword;
  final TextEditingController? textEditingController;
  final bool isNumber;
  final double textSize;
  final prefixIcon;
  final int maxLine;
  final TextInputType inputType;
  final bool isReadOnly;
  GestureTapCallback? onTap;

  TextEditingController? controller;
  CustomTextbox({
    Key? key,
    this.width = 342,
    this.textEditingController,
    this.isPassword = false,
    this.isNumber = false,
    this.prefixIcon,
    this.onTap,
    this.text = "example@gmail.com",
    this.textSize = 14,
    this.height = 50,
    this.maxLine = 1,
    this.inputType = TextInputType.text,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<CustomTextbox> createState() => _CustomTextboxState();
}

class _CustomTextboxState extends State<CustomTextbox> {
  bool isObscure = false;
  @override
  void initState() {
    super.initState();
    print(widget.isPassword == true);
    setState(() {
      isObscure = widget.isPassword == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: AppColors.textbox,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            // BoxShadow(
            //     color: AppColors.textbox, blurRadius: 5.0, offset: Offset(0, 2))
          ]),
      child: Center(
        child: TextFormField(
          maxLines: widget.maxLine,
          onTap: widget.onTap,
          textAlignVertical: TextAlignVertical.center,
          controller: widget.textEditingController,
          readOnly: widget.isReadOnly,
          obscureText: isObscure,
          cursorColor: AppColors.textboxtext,
          style: TextStyle(
            color: AppColors.textboxwritten,
            fontWeight: FontWeight.w400,
            fontSize: widget.textSize,
          ),
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: widget.prefixIcon,
            disabledBorder: InputBorder.none,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.textboxicon,
                      size: 20,
                    ))
                : SizedBox(),
            hintText: widget.text,
            hintStyle: TextStyle(

                // color: Color(0xffFFFFFF)
                color: AppColors.textboxtext,
                fontSize: widget.textSize,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
