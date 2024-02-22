import 'package:ahbas/utils/colors.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingBottomSheet extends StatelessWidget {
  const WorkingBottomSheet({
    super.key,
    required this.title, required this.itemList,
  });
  final String title;
  final List<String> itemList;
  

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
              child:
              
               Column(
                children: List.generate(
                  itemList.length,
                  (index) => CheckboxListTile(
                    tileColor: Colors.white,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      itemList[index],
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
