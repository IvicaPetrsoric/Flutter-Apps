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
        maxY: 11,
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
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 8,
                color: lerpGradient(
                    barData.colors, barData.colorStops, percent / 100),
                strokeWidth: 2,
                strokeColor: Colors.black,
              ),
              // getDotPainter: (spot, percent, barData, index) => FlDotPainter(),
              //     FlDotCirclePainter(
              //   radius: 12,
              //   color: Colors.deepOrange.withOpacity(0.5),
              // ),
            ),
            isStrokeCapRound: true,
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 2.5),
              FlSpot(8, 9),
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
          reservedSize: 40,
          getTextStyles: (value) => TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 2:
                return '20k';
              case 3:
                return '30k';
              case 4:
                return '40k';
              case 5:
                return '50k';
              case 6:
                return '60k';
              case 7:
                return '70k';
              case 8:
                return '80k';
              case 9:
                return '90k';
              case 10:
                return '100k';
              case 11:
                return '110k';
            }
            return '';
          },
          margin: 24,
        ),
      );
}

Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (stops == null || stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / colors.length;
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}
