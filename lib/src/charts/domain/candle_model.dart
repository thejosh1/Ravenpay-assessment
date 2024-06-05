class CandleData {
  CandleData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;// Add volume property
}

class CandleSerie {
  CandleSerie({
    required this.dataSource,
    required this.xValueMapper,
    required this.lowValueMapper,
    required this.highValueMapper,
    required this.openValueMapper,
    required this.closeValueMapper,
  });
  final List<CandleData> dataSource;
  final DateTime Function(CandleData, int) xValueMapper;
  final double Function(CandleData, int) lowValueMapper;
  final double Function(CandleData, int) highValueMapper;
  final double Function(CandleData, int) openValueMapper;
  final double Function(CandleData, int) closeValueMapper;
}
