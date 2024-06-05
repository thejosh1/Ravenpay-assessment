import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/colors.dart';
import 'package:ravenpay_assessment/core/res/media_res.dart';
import 'package:ravenpay_assessment/core/theme/app_themes.dart';
import 'package:ravenpay_assessment/core/theme/bloc/theme/theme_bloc.dart';
import 'package:ravenpay_assessment/src/charts/domain/candle_stick_model.dart';
import 'package:ravenpay_assessment/src/main_page/presentation/views/components/chat_view.dart';

import 'package:ravenpay_assessment/src/main_page/presentation/views/components/enums.dart';
import 'package:ravenpay_assessment/src/main_page/presentation/views/components/kBottomModal.dart';
import 'package:ravenpay_assessment/src/main_page/presentation/views/components/orderbook.dart';

import 'components/popup.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool onTap1 = true;
  bool onTap2 = false;
  bool onTap3 = false;
  bool openOrders = true;
  bool positions = false;
  bool onText = false;
  Map<String, String>? _selectedItem;

  TabSelection selectedTab = TabSelection.charts;
  TabSelection2 selectedTab2 = TabSelection2.openOrders;
  final PageController _pageController = PageController();
  final PageController _pageController1 = PageController();
  bool toogleTheme = false;

  final List<Map<String, String>> _items = [
    {'text': 'BTC/USDT', 'image': MediaRes.btcUsdt},
  ];

  late Future<List<dynamic>> _candlestickData;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedItem with the first item's text
    _selectedItem = _items[0];
  }

  Widget buildTabWidget(TabSelection tab, String title) {
    final isSelected = selectedTab == tab;

    return GestureDetector(onTap: () {
      setState(() {
        selectedTab = tab;
        _pageController1.jumpToPage(TabSelection.values.indexOf(tab));
      });
    }, child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: state.themeData.brightness == Brightness.light
                ? Colors.transparent
                : AppColors.lightBackground,
          ),
          child: Container(
            width: 109.w,
            height: 34.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: toogleTheme
                  ? isSelected ? Colors.white : AppColors.lightBackground
                  : isSelected ? AppColors.lightGrey : AppColors.black200),
              color: toogleTheme
                  ? isSelected ? Colors.white : AppColors.lightBackground
                  : isSelected ? AppColors.lightGrey : AppColors.black200,
            ),
            child: Center(
              child: Text(title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: state.themeData.brightness == Brightness.light
                      ? isSelected
                      ? Colors.black
                      : AppColors.deepText
                      : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    ),);
  }

  Widget buildTabWidget2(TabSelection2 tab2, String title) {
    final isTapped = selectedTab2 == tab2;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab2 = tab2;
          _pageController.jumpToPage(TabSelection2.values.indexOf(tab2));
        });
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
            width: 159.w,
            height: 36.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: toogleTheme
                  ? isTapped ? Colors.white : AppColors.lightBackground
                  : isTapped ? AppColors.lightGrey : AppColors.black200),
              color: toogleTheme
                  ? isTapped ? Colors.white : AppColors.lightBackground
                  : isTapped ? AppColors.lightGrey : AppColors.black200,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: state.themeData.brightness == Brightness.light
                      ? isTapped
                      ? Colors.black
                      : AppColors.deepText
                      : Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final crypto = Crypto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      toogleTheme ? AppColors.lightBackground : AppColors.darkGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 108.h,
              color: toogleTheme
                  ? appThemeData[AppTheme.lightTheme]?.primaryColor
                  : appThemeData[AppTheme.darkTheme]?.primaryColor,
              padding: EdgeInsets.only(
                left: 16.w,
                top: 43.h,
                right: 16.w,
                bottom: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        toogleTheme
                            ? MediaRes.bannerIcon2
                            : MediaRes.bannerIcon,
                        width: 20.76,
                        height: 34.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 9.29.w,
                      ),
                      Image.asset(
                        toogleTheme ? MediaRes.logoText2 : MediaRes.logoText,
                        fit: BoxFit.cover,
                        width: 90.33.w,
                        height: 19.3.h,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.avatarBackgroundColor,
                          image: DecorationImage(
                            image: AssetImage(MediaRes.avatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      InkWell(
                        onTap: () {
                          toogleTheme = !toogleTheme;
                          BlocProvider.of<ThemeBloc>(context).add(
                            ThemeChanged(
                              theme: toogleTheme
                                  ? AppTheme.lightTheme
                                  : AppTheme.darkTheme,
                            ),
                          );
                          setState(() {});
                        },
                        child: Image.asset(
                          MediaRes.globalIcon,
                          fit: BoxFit.cover,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      const kPopupMenu(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: double.maxFinite,
              height: 126.h,
              color: toogleTheme
                  ? appThemeData[AppTheme.lightTheme]?.primaryColor
                  : appThemeData[AppTheme.darkTheme]?.primaryColor,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 20.h,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: toogleTheme
                              ? appThemeData[AppTheme.lightTheme]?.primaryColor
                              : appThemeData[AppTheme.darkTheme]?.primaryColor,
                          // Set the dropdown list background color
                        ),
                        child: DropdownButton<Map<String, String>>(
                          value: _selectedItem,
                          items: _items.map((item) {
                            return DropdownMenuItem<Map<String, String>>(
                              value: item,
                              child: ColoredBox(
                                color: toogleTheme
                                    ? appThemeData[AppTheme.lightTheme]!
                                    .primaryColor
                                    : appThemeData[AppTheme.darkTheme]!
                                    .primaryColor,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      item['image']!,
                                      width: 44.w,
                                      height: 24.h,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      item['text']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp,
                                        color: toogleTheme
                                            ? appThemeData[AppTheme.darkTheme]
                                            ?.primaryColor
                                            : appThemeData[AppTheme.lightTheme]
                                            ?.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (Map<String, String>? newValue) {
                            setState(() {
                              _selectedItem = newValue;
                            });
                          },
                          underline: const SizedBox.shrink(),
                          icon: Image.asset(
                            MediaRes.dropdownIcon,
                            fit: BoxFit.cover,
                            width: 6.16.w,
                            height: 9.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        r'$20.634',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                MediaRes.clockIcon,
                                fit: BoxFit.cover,
                                width: 16.w,
                                height: 16.h,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                '24h changes',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '520.80 +1.25%',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 27.w,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                MediaRes.arrowUp,
                                fit: BoxFit.cover,
                                width: 6.w,
                                height: 9.33.h,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                '24h high',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '520.80 +1.25%',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: toogleTheme
                                  ? appThemeData[AppTheme.darkTheme]
                                  ?.primaryColor
                                  : appThemeData[AppTheme.lightTheme]
                                  ?.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                MediaRes.arrowDown,
                                fit: BoxFit.cover,
                                width: 6.w,
                                height: 9.33.h,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                '24h low',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '520.80 +1.25%',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: toogleTheme
                                  ? appThemeData[AppTheme.darkTheme]
                                  ?.primaryColor
                                  : appThemeData[AppTheme.lightTheme]
                                  ?.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 591.h,
              width: double.maxFinite,
              color: toogleTheme
                  ? appThemeData[AppTheme.lightTheme]?.primaryColor
                  : appThemeData[AppTheme.darkTheme]?.primaryColor,
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: toogleTheme
                          ? AppColors.lightBackground
                          : AppColors.lightGrey,
                    ),
                    child: Row(
                      children: [
                        buildTabWidget(TabSelection.charts, 'Charts'),
                        buildTabWidget(TabSelection.orderbook, 'Orderbook'),
                        buildTabWidget(
                          TabSelection.recentTrades,
                          'Recent trades',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController1,
                      onPageChanged: (index) {
                        setState(() {
                          selectedTab2 = TabSelection2.values[index];
                        });
                      },
                      children: [
                        SizedBox(
                          height: 409.h,
                          width: double.maxFinite,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              ChartView(),
                            ],
                          ),
                        ),
                        OrderBookWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: double.maxFinite,
              height: 350.h,
              color: toogleTheme
                  ? appThemeData[AppTheme.lightTheme]?.primaryColor
                  : AppColors.black200,
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Container(
                          width: 640.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppTheme == AppTheme.lightTheme
                                ? AppColors.lightBackground
                                : Colors.black.withOpacity(0.16),
                          ),
                          child: Row(
                            children: [
                              buildTabWidget2(
                                TabSelection2.openOrders,
                                'Open Orders',
                              ),
                              buildTabWidget2(
                                TabSelection2.positions,
                                'Positions',
                              ),
                              buildTabWidget2(
                                TabSelection2.onSomethingText,
                                'On something text',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          selectedTab2 = TabSelection2.values[index];
                        });
                      },
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Open Orders',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 48.w, right: 48.w),
                              child: Text(
                                'Lorem ipsum dolor sit amet, '
                                    'consectetur adipiscing elit. '
                                    'Id pulvinar nullam sit imperdiet pulvinar.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: toogleTheme
                                      ? appThemeData[AppTheme.darkTheme]
                                      ?.primaryColor
                                      : appThemeData[AppTheme.lightTheme]
                                      ?.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Open Positions',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: toogleTheme
                                    ? appThemeData[AppTheme.darkTheme]
                                    ?.primaryColor
                                    : appThemeData[AppTheme.lightTheme]
                                    ?.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 48.w, right: 48.w),
                              child: Text(
                                'Lorem ipsum dolor sit amet, '
                                    'consectetur adipiscing elit. '
                                    'Id pulvinar nullam sit imperdiet pulvinar.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: toogleTheme
                                      ? appThemeData[AppTheme.darkTheme]
                                      ?.primaryColor
                                      : appThemeData[AppTheme.lightTheme]
                                      ?.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Open OnSomething',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: toogleTheme
                                    ? appThemeData[AppTheme.darkTheme]
                                    ?.primaryColor
                                    : appThemeData[AppTheme.lightTheme]
                                    ?.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 48.w, right: 48.w),
                              child: Text(
                                'Lorem ipsum dolor sit amet, '
                                    'consectetur adipiscing elit. '
                                    'Id pulvinar nullam sit imperdiet pulvinar.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: toogleTheme
                                      ? appThemeData[AppTheme.darkTheme]
                                      ?.primaryColor
                                      : appThemeData[AppTheme.lightTheme]
                                      ?.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 64.h,
              color: toogleTheme ? Colors.white : Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      showBottomModal(context);
                    },
                    child: Container(
                      width: 171.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.green,
                      ),
                      child: Center(
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 171.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        'Sell',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
