import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meditasi/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final box = GetStorage(); // Initialize GetStorage

  ProfileScreen() {
    // Load saved phone and location from local storage (if exists)
    phoneController.text = box.read('phone') ?? '0812-8877-3590'; // Default value if not found
    locationController.text = box.read('location') ?? 'Malang, Indonesia'; // Default value if not found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.imagePath.value.isNotEmpty
                            ? FileImage(File(controller.imagePath.value))
                            : null,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Text(
                  'Your information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(fontSize: 13, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fadhil Rahman',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Birthday',
                                style: TextStyle(fontSize: 13, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '17 Nov 2003',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                buildEditableInfoColumn('Phone', phoneController),
                buildEditableInfoColumn('Location', locationController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableInfoColumn(String title, TextEditingController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.edit,
                size: 16,
                color: Colors.grey,
              ),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your $title',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Simpan data baru ke GetStorage
                  box.write(title.toLowerCase(), controller.text);
                  Get.snackbar('Success', '$title updated to: ${controller.text}');
                },
                child: Text('Save'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Hapus data dari GetStorage
                  controller.clear();
                  box.remove(title.toLowerCase());
                  Get.snackbar('Deleted', '$title has been deleted');
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
