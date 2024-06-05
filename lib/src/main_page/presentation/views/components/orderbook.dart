import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/colors.dart';
import 'package:ravenpay_assessment/core/res/media_res.dart';
import 'package:ravenpay_assessment/src/charts/data/websocket_sevice.dart';
import 'package:ravenpay_assessment/src/charts/domain/order_model.dart';

class OrderBookWidget extends StatefulWidget {
  @override
  _OrderBookWidgetState createState() => _OrderBookWidgetState();
}

class _OrderBookWidgetState extends State<OrderBookWidget> {
  late Future<OrderBook> futureOrderBook;

  @override
  void initState() {
    super.initState();
    futureOrderBook = fetchOrderBook();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: FutureBuilder<OrderBook>(
        future: futureOrderBook,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: AppColors.smallGrey,
                          ),
                          child: Center(
                            child: Image.asset(
                              MediaRes.orderIcon,
                              width: 12.w,
                              height: 10.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Image.asset(
                              MediaRes.orderIcon,
                              width: 12.w,
                              height: 10.h,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 32.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Image.asset(
                              MediaRes.orderIcon,
                              width: 12.w,
                              height: 10.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 63.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppColors.smallGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '10',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.orderText,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: 24.w,
                            height: 24.h,
                            color: Colors.transparent,
                            child: Image.asset(
                              MediaRes.arrowDropdown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Price\n(USDT)',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                    SizedBox(
                      width: 82.w,
                    ),
                    Text(
                      'Amount\n    (BTC)',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                    SizedBox(
                      width: 84.w,
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyText),
                    ),
                  ],
                ),
                SizedBox(height: 4.h,),
                Expanded(
                  child: _buildOrderList(snapshot.data!.asks, Colors.red),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '36.641',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.green,
                      ),
                    ),
                    Image.asset(
                      MediaRes.arrowUpGreen,
                      width: 9.33.w,
                      height: 6.h,
                    ),
                    Text(
                      '36.641',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 19.h,
                ),
                Expanded(
                  child: _buildOrderList(snapshot.data!.bids, Colors.green),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Text(
  // 'Price\n(uSDT)',
  // style: TextStyle(
  // fontWeight: FontWeight.w500,
  // fontSize: 12.sp,
  // color: AppColors.greyText),
  // ),

  Widget _buildOrderList(List<Order> orders, Color color) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.price.toString(), style: TextStyle(color: color)),
                SizedBox(
                  height: 8.5.h,
                ),
              ],
            ),
            SizedBox(
              width: 82.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.quantity.toString()),
                SizedBox(
                  height: 8.5.h,
                ),
              ],
            ),
            SizedBox(
              width: 72.w,
            ),
            //dummy data
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('28.020.98', style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 8.5.h,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
