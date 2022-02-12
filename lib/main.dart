import 'package:flutter/material.dart';
import 'package:my_app/controllers/files_controller.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/pdf_controller.dart';
import 'package:my_app/views/home_page.dart';
import 'package:my_app/widgets/pdf_page.dart';
//Camera Plugins
import 'package:camera/camera.dart';
import 'dart:async';

late List<CameraDescription> cameras;

// import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Get.put(FilesControler());
  runApp(const GetMaterialApp(
    home: HomePage(),
  ));
}
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(FilesControler());
//   runApp(const GetMaterialApp(
//     home: HomePage(),
//   ));
// }
