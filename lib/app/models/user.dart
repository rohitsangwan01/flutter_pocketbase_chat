import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_chat/app/services/pocketbase_service.dart';

class User {
  User({
    required this.id,
    required this.created,
    required this.updated,
    required this.collectionId,
    required this.collectionName,
    required this.avatar,
    required this.email,
    required this.emailVisibility,
    required this.name,
    required this.username,
    required this.verified,
    this.token,
  });

  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  final String? avatar;
  final String? email;
  final bool? emailVisibility;
  final String? name;
  final String? username;
  final bool? verified;
  String? token;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      created: DateTime.tryParse(json["created"] ?? ""),
      updated: DateTime.tryParse(json["updated"] ?? ""),
      collectionId: json["collectionId"],
      collectionName: json["collectionName"],
      avatar: json["avatar"],
      email: json["email"],
      emailVisibility: json["emailVisibility"],
      name: json["name"],
      username: json["username"],
      verified: json["verified"],
    );
  }

  Uri? get getProfilePic => avatar?.isEmpty == true
      ? null
      : PocketbaseService.to.getFileUrl(
          RecordModel(
            id: id ?? "",
            collectionId: collectionId ?? "",
            collectionName: collectionName ?? "",
          ),
          avatar ?? "");
  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "collectionId": collectionId,
        "collectionName": collectionName,
        "avatar": avatar,
        "email": email,
        "emailVisibility": emailVisibility,
        "name": name,
        "username": username,
        "verified": verified,
        "token": token,
      };
}
