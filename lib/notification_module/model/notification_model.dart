class NotificationModel {
  NotificationModel({
    this.id,
    this.title,
    this.senderId,
    this.receiverId,
    this.senderName,
    this.designation,
    this.createdAt,
    this.isActive,
    this.message,
  });
  String? id;
  String? title;
  String? senderId;
  String? receiverId;
  String? senderName;
  String? designation;
  String? createdAt;
  bool? isActive;
  String? message;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    senderName = json['sender_name'];
    designation = json['designation'];
    createdAt = json['created_at'];
    isActive = json['isActive'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['sender_id'] = senderId;
    _data['receiver_id'] = receiverId;
    _data['sender_name'] = senderName;
    _data['designation'] = designation;
    _data['created_at'] = createdAt;
    _data['isActive'] = isActive;
    _data['message'] = message;
    return _data;
  }
}
