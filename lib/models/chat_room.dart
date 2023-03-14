class ChatRoomModel {
  static const String collectionName="Rooms";
  String? id;
  String? title;
  String? description;
  String? categoryId;

  ChatRoomModel(
      {this.id = "",
        required this.title,
        required this.description,
        required this.categoryId});

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json["id"],
    categoryId: json["categoryId"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categoryId": categoryId,
      "title": title,
      "description": description,
    };
  }
}
