import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_app/controllers/files_controller.dart';
import 'package:my_app/controllers/pdf_controller.dart';
import 'package:my_app/widgets/pdf_page.dart';
import 'package:path/path.dart';
import 'package:camera/camera.dart';
import 'package:my_app/main.dart';

class HomePage extends GetView<FilesControler> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                color: Colors.deepPurpleAccent,
                child: const DrawerHeader(
                    margin: EdgeInsets.all(0),
                    child: Center(
                      child: Text(
                        'Flip Pages',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    )),
              ),
              const ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),

              ),
              const ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                //onTap: ,

              ),
             // const TextButton(onPressed: null, child: Text("Here")),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Music'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.snackbar(
              'Not Implemented',
              'add document has not yet been implemented',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.deepPurpleAccent,
            thickness: 1,
          ),
          itemCount: controller.numFiles,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(
              basenameWithoutExtension(controller.filePaths[index]),
            ),
            onTap: () {
              final String newPath = controller.filePaths[index];
              controller.currentPath.value = newPath;
              Get.lazyPut(
                  () => PDFController(path: controller.currentPath.value),
                  tag: basenameWithoutExtension(controller.currentPath.value));
              Get.to(() => pdfPage(path: newPath, location: 'assets'));
            },
          ),
        ));
  }
}

class CameraControl extends StatefulWidget {
  const CameraControl({ Key? key }) : super(key: key);
  @override
  _CameraControlState createState() => _CameraControlState();
}

class _CameraControlState extends State<CameraControl> {
  bool isWorking = false;
  String result = "";
  late CameraController cameraController;
  CameraImage ?imgCamera;
  late var controller;


  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }

}

