import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:image/image.dart' as image;

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

class LineChartWidget extends StatefulWidget {
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  ui.Image imageLoaded;

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
    const Color(0xffFF0000),
  ];

  @override
  void initState() {
    super.initState();

    // loadImage('assets/macka.jpg');
    getUiImage('assets/macka.jpg', 30, 60);
  }

  Future getUiImage(String imageAssetPath, int height, int width) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    image.Image baseSizeImage =
        image.decodeImage(assetImageByteData.buffer.asUint8List());
    image.Image resizeImage =
        image.copyResize(baseSizeImage, height: height, width: width);
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(resizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    // return frameInfo.image;

    setState(() => this.imageLoaded = frameInfo.image);
  }

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
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter2(
                    image: imageLoaded,
                    strokeWidth: 4,
                    color: Colors.white,
                    radius: 35,
                    strokeColor: Colors.yellow,
                  );
                }),
            isStrokeCapRound: true,
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 10),
              FlSpot(8, 5),
              FlSpot(9, 2),
              FlSpot(11, 3),
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

class FlDotCirclePainter2 extends FlDotPainter {
  /// The fill color to use for the circle
  Color color;

  /// Customizes the radius of the circle
  double radius;

  /// The stroke color to use for the circle
  Color strokeColor;

  /// The stroke width to use for the circle
  double strokeWidth;

  /// The color of the circle is determined determined by [color],
  /// [radius] determines the radius of the circle.
  /// You can have a stroke line around the circle,
  /// by setting the thickness with [strokeWidth],
  /// and you can change the color of of the stroke with [strokeColor].
  FlDotCirclePainter2({
    ui.Image image,
    Color color,
    double radius,
    Color strokeColor,
    double strokeWidth,
  })  : this.image = image,
        color = color ?? Colors.green,
        radius = radius ?? 4.0,
        strokeColor = strokeColor ?? Colors.green.darken(),
        strokeWidth = strokeWidth ?? 1.0;

  // FlDotCirclePainter2();

  ui.Image image;

  /// Implementation of the parent class to draw the circle
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    canvas.drawCircle(
        offsetInCanvas,
        radius,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);

    canvas.drawImage(
        image,
        Offset(
          offsetInCanvas.dx - image.width / 2,
          offsetInCanvas.dy - image.height / 2,
        ),
        Paint()..color = Colors.white.withAlpha(255));

    if (strokeWidth != null) {
      // canvas.drawCircle(
      //     offsetInCanvas,
      //     radius + (strokeWidth / 2),
      //     Paint()
      //       ..color = strokeColor ?? color
      //       ..strokeWidth = strokeWidth
      //       ..style = PaintingStyle.stroke);
    }
  }

  /// Implementation of the parent class to get the size of the circle
  @override
  Size getSize(FlSpot spot) {
    return Size(radius, radius);
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object> get props => [
        color,
        radius,
        strokeColor,
        strokeWidth,
      ];
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(alpha, (red * value).round(), (green * value).round(),
        (blue * value).round());
  }
}
