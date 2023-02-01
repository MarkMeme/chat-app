class Room {
  static const collectionName = 'rooms';

  String roomId;

  String title;

  String description;

  String categoryId;

  Room(
      {required this.title,
      required this.categoryId,
      required this.description,
      required this.roomId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'] as String,
            description: json['description'] as String,
            categoryId: json['category_id'] as String,
            roomId: json['room_id'] as String);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category_id': categoryId,
      'room_id': roomId
    };
  }
}
