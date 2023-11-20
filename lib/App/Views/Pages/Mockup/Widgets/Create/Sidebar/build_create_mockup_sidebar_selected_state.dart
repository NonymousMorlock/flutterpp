import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/select_image_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Models/background_type_model.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Global/build_preeset_gradient_list.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_change_fontfamily.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedState
    extends GetView<BuildCreateMockupSidebarSelectedStateController> {
  const BuildCreateMockupSidebarSelectedState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
      init: BuildCreateMockupSidebarSelectedStateController(),
      initState: (_) {},
      builder: (_) {
        return SingleChildScrollView(
          child: ExpansionTileGroup(
            toggleType: ToggleType.expandOnlyCurrent,
            children: [
              _buildLayoutStep(),
              _buildBackgroundStep(),
              _buildingIconStep(),
              _buildTitleStep(),
              _buildSubtitleStep(),
              _buildDeviceStep(),
              _buildDeviceStep(
                title: 'Device Two',
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.devices),
                    Icon(Icons.looks_two_outlined),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ExpansionTileBorderItem _buildDeviceStep({
    String? title,
    Widget? leading,
  }) {
    return ExpansionTileBorderItem(
      title: Text(title ?? 'Device'),
      leading: leading ?? const Icon(Icons.devices),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(),
        const Divider(height: 30),
        const SizedBox(height: 10),
        const BuildAlignmentOption(),
        const BuildAlignmentOption(
          title: '',
          firtIcon: Icons.vertical_align_top_rounded,
          secondIcon: Icons.vertical_align_center_rounded,
          thirdIcon: Icons.vertical_align_bottom_rounded,
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Screen',
          rightWidget: ElevatedButton(
            onPressed: () {},
            child: Text('add Screen'.capitalize!),
          ),
        ),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Frame',
          rightWidget: ElevatedButton(
            onPressed: () {},
            child: Text('edit Frame'.capitalize!),
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Size',
          rightWidget: BuildSliderWithValueBox(),
        ),
        const BuildSidebarOption(
          title: 'Rotate',
          rightWidget: BuildSliderWithValueBox(),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Stroke',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 10),
        const BuildSidebarOption(
          title: 'Shadow',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  ExpansionTileBorderItem _buildSubtitleStep() {
    return ExpansionTileBorderItem(
      title: const Text('Subtitle1'),
      leading: const Icon(Icons.text_increase),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(),
        const Divider(height: 30),
        const SizedBox(height: 10),
        const BuildAlignmentOption(),
        const SizedBox(height: 10),
        const BuildSidebarOption(
          title: 'Font size',
          rightWidget: BuildSliderWithValueBox(),
        ),
        const BuildSidebarOption(
          title: 'Line Height',
          rightWidget: BuildSliderWithValueBox(),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Color',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Stroke',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Margin',
          rightWidget: Slider(
            max: 50,
            min: 10,
            value: 30,
            onChanged: (val) => print('object'),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  ExpansionTileBorderItem _buildTitleStep() {
    return ExpansionTileBorderItem(
      title: const Text('Title'),
      leading: const Icon(Icons.text_fields),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(),
        const Divider(height: 30),
        const SizedBox(height: 10),
        FormBuilder(
          child: FormBuilderTextField(
            name: 'title',
            decoration: InputDecoration(
              hintText: 'your title',
              hintStyle: Get.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey.withOpacity(0.5)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Font family',
          rightWidget: BuildChangeFontFamily(),
        ),
        const SizedBox(height: 20),
        const BuildAlignmentOption(),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Font size',
          rightWidget: BuildSliderWithValueBox(),
        ),
        const BuildSidebarOption(
          title: 'Line Height',
          rightWidget: BuildSliderWithValueBox(),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Color',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Stroke',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Margin',
          rightWidget: Slider(
            max: 50,
            min: 10,
            value: 30,
            onChanged: (val) => print('object'),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  ExpansionTileBorderItem _buildingIconStep() {
    return ExpansionTileBorderItem(
      title: const Text('Icon'),
      leading: const Icon(Icons.invert_colors_on_sharp),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(),
        const Divider(height: 30),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Image',
          rightWidget: ElevatedButton(
            onPressed: () {},
            child: const Text('add image'),
          ),
        ),
        const SizedBox(height: 20),
        const BuildAlignmentOption(),
        const SizedBox(height: 20),
        BuildSidebarOption(
            title: 'Margin',
            rightWidget: Slider(
              max: 50,
              min: 10,
              value: 30,
              onChanged: (val) => print('object'),
            )),
        const SizedBox(height: 10),
      ],
    );
  }

  ExpansionTileBorderItem _buildBackgroundStep() {
    return ExpansionTileBorderItem(
      title: const Text('Background'),
      leading: const Icon(Icons.crop_original_rounded),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
          init: BuildCreateMockupSidebarSelectedStateController(),
          initState: (_) {},
          didChangeDependencies: (state) {
            state.controller?.updateActive();
          },
          builder: (_) {
            return BuildSidebarOption(
              title: 'Type',
              rightWidget: Obx(
                () => DropdownButton<String>(
                  value: _.activeBackgroundType.name,
                  icon: const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.arrow_downward, size: 15),
                      ],
                    ),
                  ),
                  isDense: true,
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  focusColor: Colors.transparent,
                  underline: Container(height: 0),
                  onChanged: (String? value) {
                    controller.onSelectBackgroundType(name: value ?? '');
                  },
                  items: controller.backgroundTypeList
                      .map<DropdownMenuItem<String>>(
                    (BackgroundTypeModel el) {
                      return DropdownMenuItem<String>(
                        value: el.name,
                        child: Text(
                          el.name!.capitalize!,
                          style: Get.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          },
        ),
        const Divider(height: 20),
        Obx(
          () => (controller.activeBackgroundType.id == 'solid')
              ? const _BuildSolidColorOption()
              : (controller.activeBackgroundType.id == 'gradient')
                  ? _BuildColorPresetGradient(
                      name: controller.gradientName,
                      gradient: controller.activeGradient,
                      callback: controller.onGradientSelect,
                      angleCallback: controller.updateAngle,
                    )
                  : _BuildSelectImageOption(
                      controllerTag: 'backgroundImage',
                      callback: controller.onSelectImage,
                    ),
        ),
      ],
    );
  }

  ExpansionTileBorderItem _buildLayoutStep() {
    return ExpansionTileBorderItem(
      title: const Text('Layout'),
      leading: const Icon(Icons.crop_free),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        InkWell(
          onTap: () => print('open layout dialog'),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: const Row(
              children: [
                Expanded(child: Text('Screen name')),
                Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildSelectImageOption extends StatelessWidget {
  final String? controllerTag;
  final Function(String) callback;
  const _BuildSelectImageOption({
    this.controllerTag,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectImageOptionController>(
      init: SelectImageOptionController(),
      tag: controllerTag,
      initState: (_) {},
      builder: (_) {
        return ElevatedButton(
          onPressed: () => _.getImage(),
          child: const Text('add image'),
        );
      },
    );
  }
}

class _BuildColorPresetGradient extends StatelessWidget {
  final String? name;
  final Function(GradientModel) callback;
  final GradientModel? gradient;
  final void Function(double angle)? angleCallback;
  const _BuildColorPresetGradient({
    this.name,
    required this.callback,
    this.gradient,
    this.angleCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSidebarOption(
          title: 'preset',
          rightWidget: InkWell(
            onTap: () => Get.bottomSheet(
              BuildPresetGradientList(
                onGradientSelected: callback,
              ),
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Get.theme.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(name?.limitLength(10) ?? 'Gradient name'),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Angle',
          rightWidget: BuildSlider(
            min: 0,
            max: 360,
            divisions: 360,
            controllerTag: 'gradiantAngle',
            onChanged: angleCallback,
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Color one',
          rightWidget: BuildPickColor(
            controllerTag: 'gradiantColorOne',
            initialColor: (gradient == null ||
                    gradient!.colors == null ||
                    gradient!.colors!.isEmpty)
                ? null
                : ColorHelper.hexToColor(gradient!.colors!.first),
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Color two',
          rightWidget: BuildPickColor(
            controllerTag: 'gradiantColorTwo',
            initialColor: (gradient == null ||
                    gradient!.colors == null ||
                    gradient!.colors!.isEmpty)
                ? null
                : ColorHelper.hexToColor(gradient!.colors!.last),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _BuildSolidColorOption extends StatelessWidget {
  const _BuildSolidColorOption();

  @override
  Widget build(BuildContext context) {
    return const BuildSidebarOption(
      title: 'Color',
      rightWidget: BuildPickColor(controllerTag: 'solidColor'),
    );
  }
}
