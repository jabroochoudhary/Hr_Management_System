import 'package:flutter/material.dart';
import 'package:hr_management_system/Utils/colors.dart';

class NotificationComponets {
  card({
    String title = "Leave Request",
    String senderName = "Jabran Haider",
    String designation = "Flutter Developer",
    String requestedAt = "",
    bool isActive = true,
    GestureTapCallback? onPressed,
  }) {
    final datet = DateTime.fromMicrosecondsSinceEpoch(int.parse(requestedAt));
    final date = "${datet.day}-${datet.month}-${datet.year}";
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromARGB(255, 222, 90, 255)
            : AppColors.primarycolor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.yellow : Colors.black),
                ),
                Icon(
                  isActive ? Icons.notifications_active : Icons.notifications,
                  color: isActive ? Colors.yellow : Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  senderName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  designation,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Received at: $date",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
