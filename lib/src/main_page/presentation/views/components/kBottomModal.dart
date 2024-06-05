import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/colors.dart';
import 'package:ravenpay_assessment/core/theme/app_themes.dart';
import 'package:ravenpay_assessment/core/theme/bloc/theme/theme_bloc.dart';

import 'kTextField.dart';

void showBottomModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 610 / MediaQuery.of(context).size.height,
        maxChildSize: 610 / MediaQuery.of(context).size.height,
        builder: (_, controller) {
          return const BottomModalContent();
        },
      );
    },
  );
}

class BottomModalContent extends StatefulWidget {
  const BottomModalContent({super.key});

  @override
  _BottomModalContentState createState() => _BottomModalContentState();
}

class _BottomModalContentState extends State<BottomModalContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Color> colors = [
    const Color(0xFF483BEB),
    const Color(0xFF7847E1),
    const Color(0xFFDD568D),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the state when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          height: 360.h,
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 17.w, top: 28.h, right: 17.w),
          decoration: BoxDecoration(
            color: state.themeData == appThemeData[AppTheme.lightTheme]
                ? Colors.white
                : AppColors.darkGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? AppColors.lightBackground
                      : Colors.black,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _tabController.animateTo(0);
                      },
                      child: Container(
                        width: 161.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _tabController.index == 0
                                ? AppColors.green
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          color: state.themeData ==
                                  appThemeData[AppTheme.lightTheme]
                              ? _tabController.index == 1
                                  ? Colors.white
                                  : Colors.black
                              : _tabController.index == 0
                                  ? AppColors.darkGrey2
                                  : AppColors.lightBackground,
                        ),
                        child: Center(
                          child: Text(
                            'Buy',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: state.themeData ==
                                      appThemeData[AppTheme.lightTheme]
                                  ? _tabController.index == 0
                                      ? AppColors.greyText
                                      : Colors.white
                                  : _tabController.index == 1
                                      ? Colors.black
                                      : AppColors.deepText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // _tabController.animateTo(1);
                      },
                      child: Container(
                        width: 161.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _tabController.index == 1
                                  ? AppColors.green
                                  : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          color: state.themeData ==
                                  appThemeData[AppTheme.lightTheme]
                              ? _tabController.index == 1
                                  ? AppColors.darkGrey2
                                  : Colors.black
                              : _tabController.index == 0
                                  ? AppColors.darkGrey2
                                  : Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'Sell',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: state.themeData ==
                                      appThemeData[AppTheme.lightTheme]
                                  ? _tabController.index == 0
                                      ? AppColors.greyText
                                      : Colors.white
                                  : _tabController.index == 1
                                      ? Colors.white
                                      : AppColors.deepText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 14.w, top: 16.h, right: 17.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56.w,
                                height: 26.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.smallGrey
                                      : AppColors.lightSmallGrey,
                                ),
                                child: Center(
                                  child: Text(
                                    'limit',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: state.themeData ==
                                              appThemeData[AppTheme.lightTheme]
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 37.w,
                              ),
                              Container(
                                width: 56.w,
                                height: 26.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Market',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: state.themeData ==
                                              appThemeData[AppTheme.lightTheme]
                                          ? AppColors.deepText
                                          : AppColors.greyText,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 37.w,
                              ),
                              Container(
                                width: 90.w,
                                height: 26.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Stop-limit',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: state.themeData ==
                                              appThemeData[AppTheme.lightTheme]
                                          ? AppColors.deepText
                                          : AppColors.greyText,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomTextFieldWithHint(
                            title: 'Limit price',
                            widget: Row(
                              children: [
                                Text(
                                  '0.00',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  'USD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomTextFieldWithHint(
                            title: 'Amount',
                            widget: Row(
                              children: [
                                Text(
                                  '0.00',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  'USD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomTextFieldWithHint(
                            title: 'Type',
                            widget: Row(
                              children: [
                                Text(
                                  'Good till cancelled',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                  size: 12.sp,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 16.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'Post Only',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Icon(
                                Icons.info_outline,
                                color: state.themeData ==
                                        appThemeData[AppTheme.lightTheme]
                                    ? AppColors.deepText
                                    : AppColors.greyText,
                                size: 10.sp,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                ),
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 32.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              gradient: LinearGradient(
                                colors: colors,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Buy BTC',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Divider(
                            color: state.themeData ==
                                    appThemeData[AppTheme.lightTheme]
                                ? AppColors.deepText
                                : AppColors.greyText,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total amount value',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'NGN',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: state.themeData ==
                                            appThemeData[AppTheme.lightTheme]
                                        ? AppColors.deepText
                                        : AppColors.greyText,
                                    size: 10.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            '0.00',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: state.themeData ==
                                      appThemeData[AppTheme.lightTheme]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Open orders',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                ),
                              ),
                              Text(
                                'Available',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? AppColors.deepText
                                      : AppColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '0.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: state.themeData ==
                                          appThemeData[AppTheme.lightTheme]
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: state.themeData ==
                                      appThemeData[AppTheme.lightTheme]
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          Container(
                            width: 80.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.blue,
                            ),
                            child: Center(
                              child: Text(
                                'Deposit',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                        child: Text('Sell Tab Content',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
