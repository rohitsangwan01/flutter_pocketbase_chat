class ChatRoom {
  ChatRoom({
    required this.id,
    required this.created,
    required this.updated,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    required this.chatId,
    required this.createdBy,
  });

  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  final String? name;
  final String? chatId;
  final String? createdBy;

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json["id"],
      created: DateTime.tryParse(json["created"] ?? ""),
      updated: DateTime.tryParse(json["updated"] ?? ""),
      collectionId: json["collectionId"],
      collectionName: json["collectionName"],
      name: json["name"],
      chatId: json["chat_id"],
      createdBy: json["created_by"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "collectionId": collectionId,
        "collectionName": collectionName,
        "name": name,
        "chat_id": chatId,
        "created_by": createdBy,
      };
}
