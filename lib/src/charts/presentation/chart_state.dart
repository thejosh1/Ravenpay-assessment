import 'package:equatable/equatable.dart';
import 'package:ravenpay_assessment/src/charts/domain/candle_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


abstract class ChartState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChartInitial extends ChartState {}

class ChartLoaded extends ChartState {

  ChartLoaded({required this.series});
  final List<CartesianSeries<CandleData, DateTime>> series;

  @override
  List<Object> get props => [series];
}

class ChartError extends ChartState {

  ChartError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
