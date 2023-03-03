import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/Utils/size_config.dart';

import 'custom_textbox.dart';

class TextFieldWithLabel {
  textFieldLabel({
    String label = "Father Name",
    String hint = "Enter your father name",
    TextEditingController? textEditingController,
    bool isPassword = false,
    bool isNumber = false,
    bool isReadOnly = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier * 4,
            ),
            Text(label,
                style: TextStyle(color: AppColors.textlight, fontSize: 16),
                textAlign: TextAlign.start),
          ],
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1,
        ),
        CustomTextbox(
          text: label,
          textEditingController: textEditingController,
          isPassword: isPassword,
          isNumber: isNumber,
          isReadOnly: isReadOnly,
          inputType: isNumber ? TextInputType.number : TextInputType.text,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 2,
        ),
      ],
    );
  }
}
