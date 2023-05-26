import 'package:chatview/chatview.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase_chat/app/models/chat_room.dart';
import 'package:pocketbase_chat/app/models/user.dart';
import 'package:pocketbase_chat/app/services/pocketbase_service.dart';

import '../../data/helper.dart';

class ChattingController extends GetxController {
  late ChatController chatController;
  late ChatUser currentUser;
  late ChatRoom chatsRoom;
  UnsubscribeFunc? unsubscribeFunc;
  Rx<ChatViewState> chatViewState = ChatViewState.loading.obs;

  @override
  void onInit() {
    (ChatRoom, User) args = Get.arguments;
    chatsRoom = args.$1;
    User chatUser = args.$2;
    _subscribeToChats();
    _initializeChatController(chatUser);
    loadChats();
    super.onInit();
  }

  Future<void> loadChats() async {
    try {
      chatViewState.value = ChatViewState.loading;
      List<Message> messages =
          await PocketbaseService.to.getMessages(roomId: chatsRoom.id);
      if (messages.isEmpty) {
        chatViewState.value = ChatViewState.noData;
        return;
      }
      _addNewMessages(messages);
    } catch (e) {
      showErrorSnackbar(e.toString());
      chatViewState.value = ChatViewState.error;
    }
  }

  void onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
    var messageObj = Message(
      message: message,
      messageType: messageType,
      createdAt: DateTime.now(),
      sendBy: currentUser.id,
      replyMessage: replyMessage,
    );
    if (chatController.initialMessageList.isEmpty) {
      chatViewState.value = ChatViewState.loading;
      chatController.initialMessageList = [messageObj];
      chatViewState.value = ChatViewState.hasMessages;
    } else {
      chatController.addMessage(messageObj);
    }
    await PocketbaseService.to.sendMessage(chatsRoom.id ?? "0", messageObj);
  }

  void _initializeChatController(User chatUser) {
    currentUser = ChatUser(
      name: chatUser.name ?? "no_name",
      id: chatUser.id ?? "0",
      profilePhoto: chatUser.getProfilePic?.toString(),
    );
    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      chatUsers: [currentUser],
    );
  }

  Future<void> _addNewMessages(List<Message> chatDataList) async {
    await _addNewUsers(chatDataList);
    if (chatController.initialMessageList.isEmpty) {
      chatViewState.value = ChatViewState.loading;
      chatController.initialMessageList = chatDataList;
      chatViewState.value = ChatViewState.hasMessages;
    } else {
      for (var message in chatDataList) {
        chatController.addMessage(message);
      }
    }
  }

  Future<void> _addNewUsers(List<Message> messages) async {
    for (var message in messages) {
      bool isUsersExist = chatController.chatUsers.any((user) {
        return user.id == message.sendBy;
      });
      if (!isUsersExist) {
        // use better way to get userName
        User userDetails = await PocketbaseService.to
            .getUserDetails(message.sendBy, useCache: true);
        chatController.chatUsers.add(ChatUser(
          name: userDetails.name ?? "",
          id: message.sendBy,
          profilePhoto: userDetails.getProfilePic?.toString(),
        ));
      }
    }
  }

  Future<void> _subscribeToChats() async {
    unsubscribeFunc = await PocketbaseService.to.subscribeToChatUpdates(
        roomId: chatsRoom.id ?? "0",
        onChat: (Message message) {
          if (message.sendBy != currentUser.id) {
            _addNewMessages([message]);
          }
        });
  }

  @override
  void onClose() {
    unsubscribeFunc?.call();
    super.onClose();
  }
}
