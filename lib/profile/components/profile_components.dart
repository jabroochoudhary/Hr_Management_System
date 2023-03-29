import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/size_config.dart';

import '../../Utils/colors.dart';

class ProfileComponents {
  card(
    String? keys,
    String? value,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color.fromARGB(255, 120, 161, 202),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            keys.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.background,
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 61,
            child: Text(
              value.toString(),
              softWrap: true,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textbox,
              ),
            ),
          ),
        ],
      ),
    );
  }

  sheet({
    required BuildContext context,
    GestureTapCallback? cameraPressed,
    GestureTapCallback? gallaryPressed,
    GestureTapCallback? cancelPressed,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      builder: (context) => Container(
        height: SizeConfig.heightMultiplier *
            27, // SizeConfig.heightMultiplier * 0.50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.transparent,
        width: SizeConfig.widthMultiplier * 1,
        child: Column(
          children: [
            InkWell(
              onTap: gallaryPressed,
              child: Container(
                width: SizeConfig.widthMultiplier * 95,
                height: SizeConfig.widthMultiplier * 15,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColors.primarycolor,
                ),
                child: const Center(
                  child: Text(
                    "Gallery Photo",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 5,
              width: SizeConfig.widthMultiplier * 95,
              // color: AppColors.primarycolor,
            ),
            InkWell(
              onTap: cameraPressed,
              child: Container(
                width: SizeConfig.widthMultiplier * 95,
                height: SizeConfig.widthMultiplier * 15,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: AppColors.primarycolor),
                child: const Center(
                  child: Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: cancelPressed,
              child: Container(
                width: SizeConfig.widthMultiplier * 95,
                height: SizeConfig.widthMultiplier * 15,
                decoration: BoxDecoration(
                  color: AppColors.primarycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
