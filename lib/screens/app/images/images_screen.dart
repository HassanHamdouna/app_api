import 'package:app_api/get/images_getx_contoller.dart';
import 'package:app_api/helpers/context_extenssion.dart';
import 'package:app_api/models/api_respones.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('image',
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/upload_image_screen');
                },
                icon: const Icon(Icons.camera_alt_outlined))
          ],
        ),
        body: GetX<ImagesGetxController>(
          init: ImagesGetxController(),
          builder: (ImagesGetxController controller) {
            if (controller.loading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.listImage.isNotEmpty) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: controller.listImage.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      // fit: StackFit.loose,
                      children: [
                        CachedNetworkImage(
                          imageUrl: controller.listImage[index].imageUrl!,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Container(
                            height: 50,
                            decoration:
                                const BoxDecoration(color: Colors.black26),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 20.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.listImage[index].image!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () =>
                                          deleteImage(context, index),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                  child: Text(
                'no Image',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
              ));
            }
          },
        ));
  }

  void deleteImage(BuildContext context, int index) async {
    ApiRespones apiRespones = await ImagesGetxController.to.deleteImage(index);
    context.showSnackBar(
        message: apiRespones.message, error: !apiRespones.status);
  }
}
