import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  late GetStorage _storage;

  Future<StorageService> init() async {
    await GetStorage.init();
    _storage = GetStorage();
    return this;
  }

  final _userKey = "_userKey";

  User? get user {
    if (!_storage.hasData(_userKey)) return null;
    return User.fromJson(_storage.read(_userKey));
  }

  set user(User? data) => _storage.write(_userKey, data?.toJson());
}
