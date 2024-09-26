import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'client_controller.dart';

class DatabaseController extends ClientController {
  Databases? databases;
  @override
  void onInit() {
    super.onInit();
// appwrite
    databases = Databases(client);
  }
  Future storeUserName(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "data_latihan2",
        documentId: ID.unique(),
        collectionId: "6569cbc702c6bddf15b6",
        data: map,
        permissions: [
          Permission.create(Role.user("6569ce02a7f716c5aff1")),
          Permission.read(Role.user("6569ce02a7f716c5aff1")),
          Permission.update(Role.user("6569ce02a7f716c5aff1")),
          Permission.delete(Role.user("6569ce02a7f716c5aff1")),
        ],
      );
      print("DatabaseController:: storeUserName $databases");
    } catch (error) {
      Get.defaultDialog(
          title: "Error Database",
          titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
    titleStyle: Get.context?.theme.textTheme.titleLarge,
    content: Text(
      "$error",
      style: Get.context?.theme.textTheme.bodyMedium,
      textAlign: TextAlign.center,
    ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}