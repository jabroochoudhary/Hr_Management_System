import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator {
  loading() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LoadingAnimationWidget.threeArchedCircle(
        //   color: AppColors.primarycolor,
        //   size: 30,
        // ),
        // SizedBox(
        //   width: 10,
        // ),
        Text(
          "Loading",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.primarycolor,
          ),
        ),
        LoadingAnimationWidget.waveDots(
          color: AppColors.primarycolor,
          size: 25,
        ),
      ],
    );
  }

  loadingWithLabel({String title = "Loading Data"}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.primarycolor,
          ),
        ),
        SizedBox(width: 5),
        LoadingAnimationWidget.fourRotatingDots(
          color: AppColors.primarycolor,
          size: 25,
        ),
      ],
    );
  }
}
