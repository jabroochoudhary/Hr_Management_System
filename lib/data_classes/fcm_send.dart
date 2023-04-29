import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class FCM {
  send(
      {required String title,
      required String message,
      required String collectionName,
      required String docId}) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docId)
          .get()
          .then((value) {
        sendNotification(title, message, value['FCM_token']);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendNotification(
      String title, String message, String deviceToken) async {
    String autToken =
        'AAAAl_yu77Y:APA91bECM0LM4t1UQFRDbXq9E3KRmPTSeWYkmpvb4tIn9YzGm_y3GklhyoMUY8T79Dl87GvmLi-gT8RuVhzf2uaH3XW_z2aFCbY1ZaCN5lyCxXHBY4BpUciipc-uT3CVWQcZOEdsoj5L';
    try {
      final res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$autToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': message,
              'title': title,
            },
            'priority': 'high',
            "to": deviceToken
          },
        ),
      );

      print("notification send" + res.statusCode.toString());
    } catch (e) {
      print("error push notification");
    }
  }
}
