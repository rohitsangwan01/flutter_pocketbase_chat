import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase_chat/app/data/helper.dart';
import 'package:pocketbase_chat/app/models/chat_room.dart';
import 'package:pocketbase_chat/app/routes/app_pages.dart';

import '../../models/user.dart';
import '../../services/pocketbase_service.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;
  List<ChatRoom> rooms = <ChatRoom>[];
  final _roomNameEditingController = TextEditingController();

  @override
  void onInit() {
    loadRooms();
    super.onInit();
  }

  Future<void> loadRooms() async {
    isLoading.value = true;
    try {
      rooms = await PocketbaseService.to.getRooms();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.log('GotError : $e');
      showErrorSnackbar(e.toString());
    }
  }

  void onRoomTap(ChatRoom chatRooms) {
    User? user = PocketbaseService.to.user;
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.toNamed(Routes.CHATTING, arguments: (chatRooms, user));
    }
  }

  Future<void> onRoomLongTap(ChatRoom chatRooms) async {
    // only room owner can delete room
    bool isRoomOwner =
        chatRooms.createdBy == PocketbaseService.to.user?.id.toString();
    if (!isRoomOwner) return;
    Get.defaultDialog(
      title: "Delete room",
      content: Text("Are you sure want to delete ${chatRooms.name}?"),
      onCancel: () {},
      onConfirm: () async {
        Get.back();
        try {
          await PocketbaseService.to.deleteRoom(chatRooms.id!);
          loadRooms();
        } catch (e) {
          Get.log(e.toString());
        }
      },
    );
  }

  Future<void> addNewRoom() async {
    Get.defaultDialog(
      title: "Add new room",
      content: TextFormField(
        controller: _roomNameEditingController,
        decoration: const InputDecoration(
          labelText: "Room name",
        ),
      ),
      onCancel: () {
        _roomNameEditingController.text = "";
      },
      onConfirm: () async {
        try {
          User? user = PocketbaseService.to.user;
          Get.back();
          await PocketbaseService.to.addRoom(
            _roomNameEditingController.text,
            user!.id.toString(),
          );
          loadRooms();
          _roomNameEditingController.text = "";
        } catch (e) {
          showErrorSnackbar(e.toString());
          Get.log(e.toString());
        }
      },
    );
  }

  void onLogoutTap() {
    try {
      PocketbaseService.to.logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.log(e.toString());
    }
  }
}
