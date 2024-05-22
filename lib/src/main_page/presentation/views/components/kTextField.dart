import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/colors.dart';
import 'package:ravenpay_assessment/core/theme/app_themes.dart';
import 'package:ravenpay_assessment/core/theme/bloc/theme/theme_bloc.dart';

class CustomTextFieldWithHint extends StatefulWidget {
  const CustomTextFieldWithHint({
    required this.title,
    required this.widget,
    super.key,
  });

  final String title;
  final Widget widget;

  @override
  _CustomTextFieldWithHintState createState() =>
      _CustomTextFieldWithHintState();
}

class _CustomTextFieldWithHintState extends State<CustomTextFieldWithHint> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: 40.h,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(
                    color: state.themeData == appThemeData[AppTheme.lightTheme]
                        ? AppColors.borderColor
                        : AppColors.lightBackground,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                      state.themeData == appThemeData[AppTheme.lightTheme]
                          ? AppColors.borderColor
                          : AppColors.lightBackground,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                      state.themeData == appThemeData[AppTheme.lightTheme]
                          ? AppColors.borderColor
                          : AppColors.lightBackground,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                      state.themeData == appThemeData[AppTheme.lightTheme]
                          ? AppColors.borderColor
                          : AppColors.lightBackground,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                style: TextStyle(
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? AppColors.deepText
                      : AppColors.greyText,
                ),
                cursorColor: state.themeData ==
                    appThemeData[AppTheme.lightTheme]
                    ? AppColors.deepText
                    : AppColors.greyText,
              ),
            ),
            if (_isEmpty)
              Positioned(
                left: 12.w,
                right: 12.w,
                top: 12.h,
                child: CustomHintText(
                  title: widget.title,
                  widget: widget.widget,
                ),
              ),
          ],
        );
      },
    );
  }
}

class CustomHintText extends StatelessWidget {
  const CustomHintText({required this.title, required this.widget, super.key});

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: state.themeData == appThemeData[AppTheme.lightTheme]
                        ? AppColors.deepText
                        : AppColors.greyText,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Icon(
                  Icons.info_outline,
                  color: state.themeData == appThemeData[AppTheme.lightTheme]
                      ? AppColors.deepText
                      : AppColors.greyText,
                  size: 10.sp,
                ),
              ],
            ),
            widget,
          ],
        );
      },
    );
  }
}
