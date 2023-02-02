class Message {
  static const String collectionName = 'messages';
  String messageId;

  String roomId;

  String content;

  String senderId;

  String senderName;

  int dateTime;

  Message(
      {this.messageId = '',
      required this.roomId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.senderName});

  Message.fromJson(Map<String, dynamic> json)
      : this(
          content: json['content'] as String,
          senderName: json['sender_name'] as String,
          roomId: json['room_id'] as String,
          senderId: json['sender_id'] as String,
          messageId: json['message_id'] as String,
          dateTime: json['date_time'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender_name': senderName,
      'room_id': roomId,
      'sender_id': senderId,
      'message_id': messageId,
      'date_time': dateTime
    };
  }
}
