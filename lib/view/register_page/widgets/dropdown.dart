import 'package:ahbas/controller/getx/tabbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flutter code sample for [DropdownMenu].

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  @override
  Widget build(BuildContext context) {
    final TabBarController controller = Get.put(TabBarController());

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: DropdownMenu<String>(
          inputDecorationTheme:
              const InputDecorationTheme(border: InputBorder.none),
          hintText: "Gender",
          textStyle: GoogleFonts.poppins(color: Colors.white),
          initialSelection: controller.selectedGender.value,
          onSelected: (value) {
            // This is called when the user selects an item.
            controller.selectedGender.value = value!;
          },
          dropdownMenuEntries: controller.genderList
              .map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ),
    );
  }
}
