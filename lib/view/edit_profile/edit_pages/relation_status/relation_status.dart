import 'package:ahbas/utils/colors.dart';
import 'package:ahbas/view/edit_profile/edit_pages/relation_status/bottom_sheet.dart';
import 'package:ahbas/view/edit_profile/edit_pages/work_status/add_work_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RelationStatusScreen extends StatefulWidget {
  const RelationStatusScreen({super.key});

  @override
  State<RelationStatusScreen> createState() => _RelationStatusScreenState();
}

class _RelationStatusScreenState extends State<RelationStatusScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AhabsColors.ahabsBasicBlue,
        leadingWidth: 20.w,
        title: Center(
          child: Text(
            'Relation Status',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Center(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            const DropDownBottomSheet(
              title: 'Relation Status',
              bottomSheet: RelationBottomSheet(itemList: [
                'Father',
                'Mother',
                'Brother',
                'Sister',
                'Husband',
                'Wife',
                'Friend',
                'Boyfriend',
                'Girlfriend'
              ], title: 'Relation Status'),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 45.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 10.w),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
