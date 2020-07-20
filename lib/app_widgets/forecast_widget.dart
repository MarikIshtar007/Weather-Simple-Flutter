import 'package:flutter/material.dart';
import 'forecast_tile.dart';
import 'package:intl/intl.dart';
import '../utility/forecast_image.dart';
import '../utility/forecast_tile_template.dart';

class Forecast_Horizontal_Widget extends StatelessWidget {
  Forecast_Horizontal_Widget({
    Key key,
    @required this.forecastData,
  }) : super(key: key);

  final forecastData;
  final forecastList = List<ForecastTileTemplate>();


  void createList() async{
    var theDate;
    for (final item in forecastData['list']){
      theDate = DateTime.parse(item['dt_txt']);
      forecastList.add(ForecastTileTemplate(
        time: theDate,
        temperature: item['main']['temp'].toInt(),
        iconCode: item['weather'][0]['icon'],
        tempMin: item['main']['temp_min'].toInt(),
        tempMax: item['main']['temp_max'].toInt()
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    createList();

    return Scrollbar(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: forecastList.length,
        separatorBuilder: (context, index)=> Divider(),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index){
          final item = forecastList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Tile(
                time: DateFormat('E, ha').format(item.time),
                icondata: getIconData(item.iconCode),
                temp: '${item.temperature}°',
                tempMin: 'Min: ${item.tempMin}°',
                tempMax: 'Max: ${item.tempMax}°',
              ),
            ),
          );
        },
      ),
    );
  }
}
