import 'dart:async';

import 'package:get_storage/get_storage.dart';

class LocalStorageProvider {
  final storage = GetStorage();

  Future<void> init() async {
    await GetStorage.init();
  }

  // Write data
  Future<void> write(String key, dynamic value) async {
    await storage.write(key, value);
  }

  // Read data
  T? read<T>(String key) {
    return storage.read<T>(key);
  }

  // Remove data
  Future<void> remove(String key) async {
    await storage.remove(key);
  }

  // Clear all data
  Future<void> clear() async {
    await storage.erase();
  }

  // Check if key exists
  bool hasData(String key) {
    return storage.hasData(key);
  }

  // Listen to changes
  Stream<dynamic> listen(String key) {
    final controller = StreamController<dynamic>();
    storage.listenKey(key, (value) {
      controller.add(value);
    });
    return controller.stream;
  }
}
