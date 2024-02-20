import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/profile_edit_screen.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhysicalStatusBottomSheet extends StatelessWidget {
  const PhysicalStatusBottomSheet({
    super.key,
    required this.title,  this.itemList,this.textController
  });
  final String title;
  final List<String>? itemList;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.h,
      decoration: const BoxDecoration(
          color: AhabsColors.ahabsBasicBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 250.w,
                child: Center(
                  child: Text(
                    title,
                    //   maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5.sp),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ))
            ],
          ),
          SizedBox(
            width: 250.w,
            child: SingleChildScrollView(
              child:itemList==null?
             EditingTextField(
              fieldColor: Colors.white,
              fieldLabel: title,
              isNumberfield: true,
              profileNameController:textController! ,maxLines: 1,
             ) 
              
              : Column(
                children: List.generate(
                  itemList!.length,
                  (index) => CheckboxListTile(
                    tileColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      itemList![index],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
