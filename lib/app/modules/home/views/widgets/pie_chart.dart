import 'package:breathez/app/modules/home/controllers/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/app_colors.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key, required this.dataModel});

  final DataModel dataModel;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.4,
          child: Row(
            children: <Widget>[
              const SizedBox(height: 10),
              Expanded(
                child: GetBuilder<HomeController>(builder: (controller) {
                  return StreamBuilder<DataModel>(
                      stream: controller.getDataCal(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return AspectRatio(
                              aspectRatio: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(90.0),
                                child: const CircularProgressIndicator(),
                              ));
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        return AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              // pieTouchData: PieTouchData(
                              //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              //     setState(() {
                              //       if (!event.isInterestedForInteractions ||
                              //           pieTouchResponse == null ||
                              //           pieTouchResponse.touchedSection == null) {
                              //         touchedIndex = -1;
                              //         return;
                              //       }
                              //       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                              //     });
                              //   },
                              // ),
                              borderData: FlBorderData(show: true),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,

                              sections: showingSections(snapshot.data!),
                            ),
                          ),
                        );
                      });
                }),
              ),
              const SizedBox(width: 28),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Indicator(color: AppColors.secondaryColor, text: 'Co', isSquare: true),
                    SizedBox(height: 4),
                    Indicator(color: AppColors.teal, text: 'CO2', isSquare: true),
                    SizedBox(height: 4),
                    Indicator(color: AppColors.orange, text: 'Dust Value', isSquare: true),
                    SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(DataModel data) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.secondaryColor,
            value: double.parse(data.co.toString()),
            title: '${data.co.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.teal,
            value: double.parse(data.co2.toString()),
            title: '${data.co2.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.orange,
            value: double.parse(data.dust.toString()),
            title: '${data.dust.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
