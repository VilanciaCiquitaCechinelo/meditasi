import 'package:appwrite/appwrite.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ClientController extends GetxController {
  Client client = Client();
  @override
  void onInit() {
    super.onInit();
// appwrite
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectID = "6569c7ecc40e71246d2f";
    client.setEndpoint(endPoint).setProject(projectID).setSelfSigned(status: true);
  }
}