import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/colors.dart';
import 'package:ravenpay_assessment/core/res/media_res.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_bloc.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32.h,
            width: double.maxFinite,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Row(
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyText),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      '1H',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      '2H',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      '4H',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 40.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppColors.timeColor,
                    ),
                    child: Center(
                      child: Text(
                        '1D',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyText),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      '1W',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    width: 58.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '1M',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyText),
                        ),
                        SizedBox(
                          width: 4.5.w,
                        ),
                        Image.asset(
                          MediaRes.arrowDropdown,
                          width: 7.w,
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(MediaRes.candleIcon),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 33.h,
          ),
          Row(
            children: [
              Container(
                width: 104.w,
                height: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: AppColors.timeColor,
                ),
                child: Center(
                  child: Text(
                    'Trading View',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 68.w,
                height: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'Depth',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.greyText,
                    ),
                  ),
                ),
              ),
              Image.asset(
                MediaRes.expandIcon,
                width: 16.67.w,
                height: 16.67.h,
                fit: BoxFit.cover,
              ),
            ],
          ),
          BlocBuilder<ChartBloc, ChartState>(
            builder: (context, state) {
              if (state is ChartInitial) {
                return const CircularProgressIndicator();
              } else if (state is ChartLoaded) {
                return SfCartesianChart(
                  trackballBehavior: _trackballBehavior,
                  primaryXAxis: const DateTimeAxis(),
                  primaryYAxis: const NumericAxis(
                    opposedPosition: true,
                  ),
                  series: state.series,
                );
              } else {
                return const Center(child: Text('Failed to load chart data'));
              }
            },
          )
        ],
      ),
    );
  }
}
