import 'dart:io';

import 'package:app_api/helpers/context_extenssion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  double? _progressValue = 0;


  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload image',
            style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.green,
              value: _progressValue,
              minHeight: 3,
            ),
            Expanded(
              child: _pickedImage == null
                  ? IconButton(
                      onPressed: () => _openGallery(),
                      icon: const Icon(Icons.camera, size: 60),
                    )
                  : Image.file(File(_pickedImage!.path)),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40)),
                onPressed: () => _performUpload(),
                icon: const Icon(Icons.cloud_download_rounded, color: Colors.white),
                label: Text(
                  'upload',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ))
          ],
        ),
      ),
    );
  }

  void _performUpload() {
    if (_checkData()) {
      _upload();
    }
  }
  bool _checkData() {
    if (_pickedImage != null) {
      return true;
    }
    context.showSnackBar(message: 'pick mage to upload', error: true);
    return false;
  }
  void _upload()  {
    _uploadProgress(value: 1);
  }
  void _uploadProgress({double? value}) {
    setState(() {
      _progressValue = value;
    });
  }


  void _openGallery() async {
    XFile? fileImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (fileImage != null) {
      setState(() {
        _pickedImage = fileImage;
      });
    }
  }


}
