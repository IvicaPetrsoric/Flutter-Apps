import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Color(0xff010226),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 80, 10, 80),
          child: LineChartWidget(),
        ),
      ),

      // initialRoute: OnboardingScreen.id,
      // routes: {
      //   OnboardingScreen.id: (context) => OnboardingScreen(),
      //   TabBarController.id: (context) => TabBarController(),
      // },
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    const Color(0xffFF0000),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        titlesData: LineTitles.getTitleData(),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Color(0xff37d),
            width: 1,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            colors: gradientColors,
            barWidth: 8,
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors.map((e) => e.withOpacity(0.5)).toList(),
            ),
            // dotData: FlDotData(show: false),
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 2.5),
              FlSpot(8, 4),
              FlSpot(9, 3),
              FlSpot(11, 4),
            ],
          ),
        ],
      ),
    );
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'OCT';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTextStyles: (value) => TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          margin: 8,
        ),
      );
}
