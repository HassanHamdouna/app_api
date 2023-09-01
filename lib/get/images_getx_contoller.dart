import 'package:app_api/api/controllers/images_api_controller.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:app_api/models/student_image.dart';
import 'package:get/get.dart';

class ImageGetxController extends GetxController {
  static ImageGetxController get to => Get.find();
  final ImagesApiController _apiController = ImagesApiController();
  RxList<StudentImage> listImage = <StudentImage>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    readImage ();
    super.onInit();
  }

  void readImage() async {
    loading.value = false;
    listImage.value = await _apiController.getImage();
    loading.value = true;

  }

  Future<ApiRespones> uploadImage(String path) async {
    ApiRespones apiRespones = await _apiController.uploadImage(path: path);
    if (apiRespones.status == true && apiRespones.object != null) {
      listImage.add(apiRespones.object!);
    }
    return apiRespones;
  }

  Future<ApiRespones> deleteImage(int index) async {
    ApiRespones apiRespones =
        await _apiController.deleteImage(id: listImage[index].id!);
    if (apiRespones.status == true) {
      listImage.removeAt(index);
    }
    return apiRespones;
  }
}
