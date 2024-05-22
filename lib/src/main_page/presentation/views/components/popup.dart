import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popover/popover.dart';
import 'package:ravenpay_assessment/core/res/media_res.dart';
import 'package:ravenpay_assessment/src/main_page/presentation/views/components/kmenu.dart';

class kPopupMenu extends StatelessWidget {
  const kPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showPopover(
          context: context,
          bodyBuilder: (context) => const kMenuItems(),
          width: 150.w,
          height: 192.h,
          backgroundColor: Colors.transparent,
        ),
        child: Image.asset(
          MediaRes.listIcon,
          fit: BoxFit.cover,
          width: 32.w,
          height: 32.h,
        ),
    );
  }
}
