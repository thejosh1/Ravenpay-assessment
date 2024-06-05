import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ravenpay_assessment/src/charts/domain/candle_model.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_event.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final http.Client httpClient;

  ChartBloc({required this.httpClient}) : super(ChartInitial()) {
    on<LoadChartData>(_onLoadChartData);
  }

  void _onLoadChartData(LoadChartData event, Emitter<ChartState> emit) async {
    try {
      // Simulate data fetching
      final response = await httpClient.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/bitcoin/ohlc?vs_currency=usd&days=7'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final candleData = (data as List).map((item) {
          final timestamp = item[0] as int;
          final open = (item[1] as num).toDouble();
          final high = (item[2] as num).toDouble();
          final low = (item[3] as num).toDouble();
          final close = (item[4] as num).toDouble();
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          return CandleData(
            date: date,
            open: open,
            high: high,
            low: low,
            close: close,
          );
        }).toList();
        final series = <CandleSeries<CandleData, DateTime>>[
          CandleSeries<CandleData, DateTime>(
            dataSource: candleData,
            xValueMapper: (CandleData data, _) => data.date,
            lowValueMapper: (CandleData data, _) => data.low,
            highValueMapper: (CandleData data, _) => data.high,
            openValueMapper: (CandleData data, _) => data.open,
            closeValueMapper: (CandleData data, _) => data.close,
          ),
        ];
        emit(ChartLoaded(series: series));
      } else {
        emit(ChartError(message: 'Failed to load chart data'));
      }
    } catch (e) {
      emit(ChartError(message: 'Failed to load chart data: $e'));
    }
  }
}
