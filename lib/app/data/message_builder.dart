// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import "package:http/http.dart" as http;
import 'package:chatview/chatview.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_chat/app/services/pocketbase_service.dart';

class MessageBuilder {
  /// Parse message object to save in pocketbase
  static Map<String, dynamic> parseMessageToJson(
    String roomId,
    Message message,
  ) {
    return {
      "room_id": roomId,
      "message": message.message,
      "sendBy": message.sendBy,
      "message_type": message.messageType.name,
      "voice_message_duration": message.voiceMessageDuration?.inMilliseconds,
      "createdAt": message.createdAt.toString(),
      'voiceMessageDuration': message.voiceMessageDuration,
      'reply_id': message.replyMessage.messageId,
      "replyBy": message.replyMessage.replyBy,
      "replyTo": message.replyMessage.replyTo,
      'reply_message': message.replyMessage.message,
      'reply_message_type': message.replyMessage.messageType.name,
    };
  }

  /// Parse message object to multipartList to upload file
  static List<http.MultipartFile> parseMessageToMultipart(Message message) {
    if (message.messageType == MessageType.image ||
        message.messageType == MessageType.voice) {
      http.MultipartFile multipart = http.MultipartFile.fromBytes(
        "message_file",
        File(message.message).readAsBytesSync(),
        filename: message.message.split('/').last,
      );
      return [multipart];
    }
    return [];
  }

  /// Parse json to message object
  static Future<Message> parseJsonToMessage(json, recordModel) async {
    return Message(
      id: json["id"],
      message: await _parseMessageText(json, recordModel),
      createdAt: DateFormat("yyyy-MM-dd hh:mm:ss").parse(json["createdAt"]),
      sendBy: json["sendBy"],
      messageType: _parseMessageType(json["message_type"]),
      voiceMessageDuration: _parseDuration(json["voice_message_duration"]),
      replyMessage: ReplyMessage(
        replyBy: json["replyBy"] ?? '',
        replyTo: json["replyTo"] ?? '',
        messageId: json["reply_id"] ?? '',
        message: json["reply_message"] ?? '',
        messageType: _parseMessageType(json["reply_message_type"]),
      ),
    );
  }

  /// Helper functions
  static Future<String> _parseMessageText(json, RecordModel recordModel) async {
    MessageType messageType = _parseMessageType(json["message_type"]);
    var message = json["message"];
    var messageFile = json["message_file"];
    switch (messageType) {
      case MessageType.image:
        return PocketbaseService.to
            .getFileUrl(recordModel, messageFile)
            .toString();
      case MessageType.voice:
        File? file = await PocketbaseService.to.downloadFile(
          recordModel: recordModel,
          fileName: messageFile,
          useCache: true,
        );
        return file?.path ?? "";
      default:
        return message;
    }
  }

  static MessageType _parseMessageType(type) {
    switch (type?.toString()) {
      case "text":
        return MessageType.text;
      case "image":
        return MessageType.image;
      case "voice":
        return MessageType.voice;
      default:
        return MessageType.custom;
    }
  }

  static Duration? _parseDuration(durationData) {
    int? duration = durationData;
    if (duration == null) return null;
    return Duration(milliseconds: duration);
  }
}
