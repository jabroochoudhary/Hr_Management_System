import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        cursorColor: AppColors.textlight,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: 'Search..',
          filled: true,
          fillColor: Color(0xffA3AAFA),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: Colors.black12)),
          // disabledBorder: InputBorder.none,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
                height: SizeConfig.heightMultiplier * 5,
                width: SizeConfig.widthMultiplier * 12,
                child: Icon(Icons.settings_rounded,color: Color(0xff3B3B3B),)),
          ),
        ),
      ),
    );
  }
}