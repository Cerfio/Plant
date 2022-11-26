import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plant_iot_epitech/models/plants.dart';

class LineChartSample2 extends StatefulWidget {
  final List<PlantData> plantData;
  final int maxY;
  final String type;

  const LineChartSample2({
    super.key,
    required this.plantData,
    required this.maxY,
    required this.type,
  });

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff232d37),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('-7D', style: style);
        break;
      case 3:
        text = const Text('-4D', style: style);
        break;
      case 7:
        text = const Text('0D', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget left100TitleWidgets(double value, TitleMeta meta) {
    String text = '0';
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff67727d),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget left1024TitleWidgets(double value, TitleMeta meta) {
    String text = '0';
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 512:
        text = '512';
        break;
      case 1024:
        text = '1024';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff67727d),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      textAlign: TextAlign.left,
    );
  }

  List<FlSpot> generateFlSpotData() {
    List<FlSpot> spots = [];

    if (widget.plantData.length >= 8) {
      for (int i = 0; i < 8; i++) {
        final PlantData data = widget.plantData[i];
        if (widget.type == 'light') {
          final FlSpot spot = FlSpot(i.toDouble(), data.light.toDouble());
          spots.add(spot);
        } else if (widget.type == 'temperature') {
          final FlSpot spot = FlSpot(i.toDouble(), data.temperature.toDouble());
          spots.add(spot);
        } else if (widget.type == 'humidityAir') {
          final FlSpot spot = FlSpot(i.toDouble(), data.humidityAir.toDouble());
          spots.add(spot);
        } else if (widget.type == 'humiditySoil') {
          final FlSpot spot =
              FlSpot(i.toDouble(), data.humiditySoil.toDouble());
          spots.add(spot);
        } else if (widget.type == 'pressure') {
          final FlSpot spot = FlSpot(i.toDouble(), data.pressure.toDouble());
          spots.add(spot);
        } else if (widget.type == 'battery') {
          final FlSpot spot = FlSpot(i.toDouble(), data.battery.toDouble());
          spots.add(spot);
        }
      }
    } else {
      int rest = 8 - widget.plantData.length;
      for (int i = 0; i < rest; i++) {
        final FlSpot spot = FlSpot(i.toDouble(), 0);
        spots.add(spot);
      }
      for (int i = 0; i < widget.plantData.length; i++) {
        final PlantData data = widget.plantData[i];
        if (widget.type == 'light') {
          final FlSpot spot = FlSpot(i.toDouble() + rest, data.light.toDouble());
          spots.add(spot);
        } else if (widget.type == 'temperature') {
          final FlSpot spot = FlSpot(i.toDouble() + rest, data.temperature.toDouble());
          spots.add(spot);
        } else if (widget.type == 'humidityAir') {
          final FlSpot spot = FlSpot(i.toDouble() + rest, data.humidityAir.toDouble());
          spots.add(spot);
        } else if (widget.type == 'humiditySoil') {
          final FlSpot spot =
              FlSpot(i.toDouble() + rest, data.humiditySoil.toDouble());
          spots.add(spot);
        } else if (widget.type == 'pressure') {
          final FlSpot spot = FlSpot(i.toDouble() + rest, data.pressure.toDouble());
          spots.add(spot);
        } else if (widget.type == 'battery') {
          final FlSpot spot = FlSpot(i.toDouble() + rest, data.battery.toDouble());
          spots.add(spot);
        }
      }
    }
    return spots;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget:
                widget.maxY == 100 ? left100TitleWidgets : left1024TitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: widget.maxY.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: generateFlSpotData(),

          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
