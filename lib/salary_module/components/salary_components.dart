import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';
import 'package:hr_management_system/salary_module/model/salary_model.dart';

class SalaryComponents {
  card(String text,
      {GestureTapCallback? onPressed, GestureLongPressCallback? longPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 22,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  salaryCard({
    GestureTapCallback? onPressed,
    GestureLongPressCallback? longPressed,
    required DetailsSalaryModel dt,
  }) {
    return InkWell(
      onTap: onPressed,
      onLongPress: longPressed,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dt.empName.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    dt.isPaid! ? "Paid" : "Not Paid",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: dt.isPaid! ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dt.empDesignation.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "Salary Rs. ${dt.salary}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  empSalaryCard({
    required DetailsSalaryModel dt,
    required formatedDtae,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatedDtae.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  dt.isPaid! ? "Paid" : "Not Paid",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: dt.isPaid! ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dt.empDesignation.toString(),
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  "Salary Rs. ${dt.salary}",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
