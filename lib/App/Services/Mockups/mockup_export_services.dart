import 'dart:typed_data';

import 'package:device_frame/device_frame.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_device_card.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as IMG;
import 'package:image/image.dart';
import 'package:screenshot/screenshot.dart';

class MockupExportServices {
  FileManegerProvider fileManegerProvider = FileManegerProvider();

  // Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  // screenshot
  Future<Uint8List> takeScreenshot(
    TemplateConfigModel item, {
    DeviceInfo? device,
    double? width,
    double? height,
  }) async {
    screenshotController.capture(delay: const Duration(milliseconds: 10));

    return await screenshotController.captureFromWidget(
      BuildDeviceBody(
        config: item,
        device: device,
        width: width ?? 430,
        height: height ?? 932,
      ),
      context: Get.context!,
      delay: const Duration(seconds: 1),
      pixelRatio: 4,
    );
  }

  // export
  Future<void> export({required List<TemplateConfigModel> items}) async {
    // get path
    String? path = await fileManegerProvider.userPickFileLocation();

    if (path == null) return;

    String folderName = 'FlutterPP Screenshots';
    String homePath = '$path/$folderName/';
    String original = '$homePath/original/';
    String ios = '$homePath/ios/';
    String ios67 = '$ios/Apple_(1290x2796)';
    String ios65 = '$ios/Apple_(1284x2778)';
    String ios55 = '$ios/Apple_(1242x2208)';
    String android = '$homePath/android/';

    await createFolders(path: path, folderName: folderName);

    // // pre images
    List<Uint8List> preImages = [];
    List<Uint8List> preIos55Images = [];

    // screenshot original images
    for (var item in items) {
      Uint8List local = await takeScreenshot(item);
      preImages.add(local);

      Uint8List local2 = await takeScreenshot(
        item,
        width: 310.5,
        height: 552,
        device: Devices.ios.iPhoneSE,
      );
      preIos55Images.add(local2);
    }

    // save ios67 images
    for (var i = 0; i < preImages.length; i++) {
      Uint8List? ios67Image = await resizeImage(preImages[i], 1290, 2796);
      Uint8List? ios65Image = await resizeImage(preImages[i], 1284, 2778);

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: ios67,
        bytes: ios67Image,
      );

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: ios65,
        bytes: ios65Image,
      );
    }

    // save ios55 images
    for (var i = 0; i < preIos55Images.length; i++) {
      Uint8List? ios55Image = await resizeImage(preIos55Images[i], 1242, 2208);

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: ios55,
        bytes: ios55Image,
      );
    }
  }

  // resize image
  Future<Uint8List?> resizeImage(Uint8List data, width, height) async {
    // IMG.Image? img = IMG.decodeImage(data);
    // IMG.Image? resized = IMG.copyResize(
    //   img!,
    //   width: width,
    //   height: height,
    // );
    // resizedData = IMG.encodeJpg(resized);
    final com = Command()
      ..decodeImage(data)
      ..copyResize(
        width: width,
        height: height,
        interpolation: Interpolation.nearest,
      )
      ..encodeJpg();

    return IMG.executeCommandBytes(com);
  }

  // create folders
  Future<void> createFolders({
    required String path,
    required String folderName,
  }) async {
    // create new folder

    String homePath = '$path/$folderName/';

    // save locations
    String ios = '$homePath/ios/';

    // create folder
    await fileManegerProvider.createFolder(
      location: path,
      folderName: folderName,
    );

    await fileManegerProvider.createFolder(
      location: homePath,
      folderName: 'original',
    );

    await fileManegerProvider.createFolder(
      location: homePath,
      folderName: 'ios',
    );
    await fileManegerProvider.createFolder(
      location: ios,
      folderName: 'Apple_(1290x2796)',
    );
    await fileManegerProvider.createFolder(
      location: ios,
      folderName: 'Apple_(1284x2778)',
    );
    await fileManegerProvider.createFolder(
      location: ios,
      folderName: 'Apple_(1242x2208)',
    );

    await fileManegerProvider.createFolder(
      location: homePath,
      folderName: 'android',
    );
  }
}
