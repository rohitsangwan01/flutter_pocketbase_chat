// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:chatview/chatview.dart';
import 'chatting_controller.dart';
import 'package:chatview/src/models/voice_message_configuration.dart';

class ChattingView extends GetView<ChattingController> {
  const ChattingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ChatView(
          appBar: AppBar(
            title: Text(controller.chatsRoom.name?.capitalizeFirst ?? "Chat"),
            backgroundColor: Colors.black,
          ),
          chatController: controller.chatController,
          currentUser: controller.currentUser,
          chatViewState: controller.chatViewState.value,
          onSendTap: controller.onSendTap,
          chatViewStateConfig: ChatViewStateConfiguration(
            onReloadButtonTap: controller.loadChats,
          ),
          messageConfig: MessageConfiguration(
            voiceMessageConfig: VoiceMessageConfiguration(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(20),
              ),
              playIcon: const Icon(Icons.play_arrow, color: Colors.white),
              pauseIcon: const Icon(Icons.pause, color: Colors.white),
            ),
          ),
          sendMessageConfig: SendMessageConfiguration(
            textFieldBackgroundColor: Colors.grey[200],
            textFieldConfig: TextFieldConfiguration(
              textStyle: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
