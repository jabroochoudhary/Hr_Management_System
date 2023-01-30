import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class CustomAppbar extends StatefulWidget {
  final String text;
  const CustomAppbar({Key? key,
    this.text = 'App Bar'
  }) : super(key: key);

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.heightMultiplier*15,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),
          ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(143, 148, 251, .2),
            blurRadius: 20.0,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(widget.text,style: GoogleFonts.rubik(color:
          Color(0xffFFFFFF),fontWeight: FontWeight.w700,fontSize: 20),),
        ],
      ),
    );
  }
}
