import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:ravenpay_assessment/src/charts/domain/candle_model.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_bloc.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_event.dart';
import 'package:ravenpay_assessment/src/charts/presentation/chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MockHttpClient extends Mock implements http.Client {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class FakeUri extends Fake implements Uri {}

void main() {
  late ChartBloc chartBloc;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    chartBloc = ChartBloc(httpClient: mockHttpClient);
  });

  tearDown(() {
    chartBloc.close();
  });

  test('initial state is ChartInitial', () {
    expect(chartBloc.state, ChartInitial());
  });

  blocTest<ChartBloc, ChartState>(
    'emits [ChartLoaded] when LoadChartData is added and data is fetched successfully',
    build: () {
      when(() => mockHttpClient.get(any())).thenAnswer(
            (_) async => http.Response(
          jsonEncode([
            [1628073600000, 100, 110, 90, 105],
            [1628160000000, 105, 115, 95, 110],
          ]),
          200,
        ),
      );
      return chartBloc;
    },
    act: (bloc) => bloc.add(LoadChartData()),
    expect: () => [
      isA<ChartLoaded>().having(
            (state) => state.series,
        'series',
        isA<List<CartesianSeries<CandleData, DateTime>>>(),
      ),
    ],
  );

  blocTest<ChartBloc, ChartState>(
    'emits [ChartError] when LoadChartData is added and an exception is thrown',
    build: () {
      when(() => mockHttpClient.get(any())).thenThrow(Exception('Failed to fetch data'));
      return chartBloc;
    },
    act: (bloc) => bloc.add(LoadChartData()),
    expect: () => [
      isA<ChartError>().having(
            (state) => state.message,
        'message',
        contains('Failed to load chart data'),
      ),
    ],
  );
}
