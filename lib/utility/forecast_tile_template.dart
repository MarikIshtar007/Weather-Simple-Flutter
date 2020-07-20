class ForecastTileTemplate{
  final DateTime time;
  final int temperature;
  final String iconCode;
  final int tempMin;
  final int tempMax;

  ForecastTileTemplate({this.tempMin, this.tempMax,this.time, this.temperature, this.iconCode});
}