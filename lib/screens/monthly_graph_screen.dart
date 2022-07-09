// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class MonthlyGraphScreen extends StatelessWidget {
  MonthlyGraphScreen({Key? key, required this.graphData}) : super(key: key);

  final List<Map<String, int>> graphData;

  List<FlSpot> flspots = [];

  int graphMax = 0;
  int graphMin = 0;

  ///
  @override
  Widget build(BuildContext context) {
    List<int> list = [];
    for (var i = 0; i < graphData.length; i++) {
      flspots.add(
        FlSpot(
          double.parse((i + 1).toString()),
          double.parse(graphData[i]['total'].toString()),
        ),
      );

      list.add(int.parse(graphData[i]['total'].toString()));
    }

    //-----------------------//
    var minValue = list.reduce(min);
    var maxValue = list.reduce(max);

    graphMin = ((minValue / 1000000).ceil() - 1) * 1000000 + 500000;
    graphMax = ((maxValue / 1000000).floor() + 1) * 1000000 - 500000;
    //-----------------------//

    setChartData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graph Screen'),
      ),
      body: LineChart(data),
    );
  }

  ///
  LineChartData data = LineChartData();

  void setChartData() {
    data = LineChartData(
      ///
      minX: 1,
      minY: double.parse(graphMin.toString()),
      //
      maxX: double.parse(flspots.length.toString()),
      maxY: double.parse(graphMax.toString()),

      ///
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0.3),
        ),
      ),

      ///
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,

        //横線
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white30,
            strokeWidth: 1,
          );
        },

        //縦線
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white38,
            strokeWidth: 1,
          );
        },
      ),

      ///
      /// 全体の枠
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.white38,
          width: 2,
        ),
      ),

      ///
      lineBarsData: [
        LineChartBarData(
          spots: flspots,
//          isCurved: true,//グラフを曲線にするか
          barWidth: 5,
          isStrokeCapRound: true,
          color: Colors.yellowAccent,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.yellowAccent.withOpacity(0.1),
          ), // グラフの下の塗り
        ),
      ],

      ///
    );
  }
}
