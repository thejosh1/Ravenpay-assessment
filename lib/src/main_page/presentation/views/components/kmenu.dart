import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/colors.dart';
import 'package:ravenpay_assessment/core/theme/app_themes.dart';
import 'package:ravenpay_assessment/core/theme/bloc/theme/theme_bloc.dart';

class kMenuItems extends StatelessWidget {
  const kMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150.w,
              padding: EdgeInsets.only(left: 16.w, top: 13.h),
              height: 48.h,
              color: state.themeData == appThemeData[AppTheme.lightTheme]
                  ? AppColors.darkGrey
                  : Colors.white,
              child: Text(
                'Exchange',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 150.w,
              padding: EdgeInsets.only(left: 16.w, top: 13.h),
              height: 48.h,
              color: state.themeData == appThemeData[AppTheme.lightTheme]
                  ? AppColors.menuBackground
                  : AppColors.lightBackground,
              child: Text(
                'Wallet',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 150.w,
              padding: EdgeInsets.only(left: 16.w, top: 13.h),
              height: 48.h,
              color: state.themeData == appThemeData[AppTheme.lightTheme]
                  ? AppColors.darkGrey
                  : Colors.white,
              child: Text(
                'Roqque Hub',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            Container(
              width: 150.w,
              padding: EdgeInsets.only(left: 16.w, top: 13.h),
              height: 48.h,
              color: state.themeData == appThemeData[AppTheme.lightTheme]
                  ? AppColors.darkGrey
                  : Colors.white,
              child: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
