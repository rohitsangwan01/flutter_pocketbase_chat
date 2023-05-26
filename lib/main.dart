import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pocketbase_chat/app/services/storage_service.dart';

import 'app/routes/app_pages.dart';
import 'app/services/pocketbase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => PocketbaseService().init());

  runApp(
    GetMaterialApp(
      title: "PocketBase Chat",
      debugShowCheckedModeBanner: false,
      initialRoute:
          PocketbaseService.to.isAuth ? Routes.DASHBOARD : Routes.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
