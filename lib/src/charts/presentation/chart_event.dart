import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadChartData extends ChartEvent {}
