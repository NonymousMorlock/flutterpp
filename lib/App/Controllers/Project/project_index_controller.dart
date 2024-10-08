// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutterpp/App/Models/project_model.dart';
// import 'package:flutterpp/App/Models/team_model.dart';
// import 'package:flutterpp/App/Services/Project/project_services.dart';
// import 'package:flutterpp/App/Services/Team/team_services.dart';
// import 'package:flutterpp/App/Views/Global/build_overlay.dart';
// import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
// import 'package:flutterpp/Config/Bindings/Project/app_project_binding.dart';
// import 'package:flutterpp/Config/app_gradients.dart';
// import 'package:flutterpp/Helpers/colors_helper.dart';
// import 'package:get/get.dart';

// class ProjectIndexController extends GetxController {
//   final ProjectServices _projectServices = ProjectServices();
//   final TeamServices _teamServices = TeamServices();

//   final _isLoading = true.obs;
//   bool get isLoading => _isLoading.value;

//   final _team = TeamModel().obs;
//   TeamModel get team => _team.value;

//   final _projects = <ProjectModel>[].obs;
//   List<ProjectModel> get projects => _projects;

//   final _activeProject = ProjectModel().obs;
//   ProjectModel get activeProject => _activeProject.value;

//   final _colors = <List<Color>>[].obs;
//   List<List<Color>> get colors => _colors;

//   final _selectedColors = <Color>[].obs;
//   List<Color> get selectedColors => _selectedColors;

//   final _oreginalSelectedColors = <String>[].obs;
//   List<String> get oreginalSelectedColors => _oreginalSelectedColors;

//   final _svgs = <String>[].obs;
//   List<String> get svgs => _svgs;

//   final _selectedSVG = ''.obs;
//   String get selectedSVG => _selectedSVG.value;

//   @override
//   void onInit() {
//     AppProjectBinding.int();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     AppProjectBinding.close();
//     super.onClose();
//   }

//   @override
//   Future<void> onReady() async {
//     await _fetchTeamAndProjects();
//     _listOfColors();
//     await _listOFSVGs();

//     super.onReady();
//   }

//   // fetch team and projects
//   Future<void> _fetchTeamAndProjects() async {
//     Get.showOverlay(
//       loadingWidget: const BuildOverlay(),
//       asyncFunction: () async {
//         TeamModel? team = await _teamServices.getTeamForAuthUser();
//         List<ProjectModel>? projects = await _projectServices.getProjects(
//           teamId: team!.id!,
//         );

//         _team.value = team;
//         _projects.value = projects!;

//         if (projects.isNotEmpty) {
//           onProjectChange(projects.first);
//         }

//         updateLoading(false);
//       },
//     );
//   }

//   // list of colors
//   void _listOfColors() {
//     var localColors = AppGradients.getRandomColors();
//     _colors.addAll(localColors);
//     update();

//     onColorChange(localColors[Random().nextInt(localColors.length)]);
//   }

//   // list of svg
//   _listOFSVGs() async {
//     final manifestJson = await DefaultAssetBundle.of(Get.context!)
//         .loadString('AssetManifest.json');
//     final allFiles = json
//         .decode(manifestJson)
//         .keys
//         .where((String key) => key.startsWith('assets/svg'))
//         .toList();

//     // remover what not ends with .svg
//     allFiles.removeWhere((element) => !element.endsWith('.svg'));

//     // remove assets/svg/
//     List svgs = allFiles.map((e) => e.replaceFirst('assets/svg/', '')).toList();

//     // convert each item in the array to a string
//     List<String> arr = svgs.map((e) => e.toString()).toList();

//     // add to _svgs
//     _svgs.addAll(arr);
//     update();

//     // set random svg
//     onSVGChange(_svgs[Random().nextInt(_svgs.length)]);
//   }

//   // set active project
//   Future<void> onProjectChange(ProjectModel project) async {
//     _activeProject.value = project;
//     update();

//     // // update project single wiki
//     // await Get.find<ProjectSingleWikiController>().fetchApi(
//     //   id: project.id!,
//     // );
//   }

//   // update loading
//   void updateLoading(bool isLoading) {
//     _isLoading.value = isLoading;
//     update();
//   }

//   // on color change
//   void onColorChange(List<Color> colors) {
//     // from colors to hexcolor
//     List<String> hexColors = colors
//         .map(
//           (e) => ColorHelper.colorToHex(e),
//         )
//         .toList();

//     // set selected colors
//     _selectedColors.value = colors;
//     _oreginalSelectedColors.value = hexColors;
//     update();
//   }

//   // on svg change
//   void onSVGChange(String svg) {
//     _selectedSVG.value = svg;
//     update();
//   }

//   // create project
//   Future<void> createProject({required Map formData}) async {
//     // make sure icon and colors are selected
//     if (_selectedSVG.value.isEmpty || _selectedColors.isEmpty) {
//       BuildSnackBar(
//         title: 'Error',
//         message: 'Please select icon and colors',
//       ).error();
//       return;
//     }

//     // form data
//     String title = formData['title'];
//     String description = formData['description'];

//     Get.showOverlay(
//       loadingWidget: const BuildOverlay(),
//       asyncFunction: () async {
//         ProjectModel? project = await _projectServices.createProject(
//           teamId: team.id!,
//           color1: ColorHelper.colorToHex(_selectedColors.first),
//           color2: ColorHelper.colorToHex(_selectedColors.last),
//           icon: _selectedSVG.value,
//           title: title,
//           description: description,
//         );

//         _projects.add(project!);
//         onProjectChange(project);
//         update();
//       },
//     );
//   }
// }
