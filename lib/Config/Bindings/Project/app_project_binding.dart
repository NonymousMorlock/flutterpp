import 'package:flutterpp/App/Controllers/Project/Single/project_single_board_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_config_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_wiki_controller.dart';
import 'package:get/get.dart';

class AppProjectBinding {
  // int
  static int() {
    Get.lazyPut<ProjectSingleController>(() => ProjectSingleController());
    Get.lazyPut<ProjectSingleWikiController>(
        () => ProjectSingleWikiController());
    Get.lazyPut<ProjectSingleBoardController>(
        () => ProjectSingleBoardController());
    Get.lazyPut<ProjectSingleConfigController>(
        () => ProjectSingleConfigController());
    Get.lazyPut<ProjectSingleCodeGenController>(
        () => ProjectSingleCodeGenController());
  }
}
