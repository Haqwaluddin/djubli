import 'package:get/get.dart';

class DetailController extends GetxController{

  var image = Get.arguments[0];
  var km = Get.arguments[1];
  var harga = Get.arguments[2];
  var lokasi = Get.arguments[3];

  @override
  void onInit() {
    print(image);
    print(km);
    print(harga);
    print(lokasi);
    // TODO: implement onInit
    super.onInit();
  }

}