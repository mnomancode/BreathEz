import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // Stream<DataModel> getData() async* {
  //   String coValue = '';
  //   String co2Value = '';
  //   String dustValue = '';

  //   // Merge the three streams using StreamController
  //   StreamController<void> controller = StreamController<void>();

  //   co.listen((event) {
  //     coValue = event.snapshot.value.toString();
  //     controller.add(null);
  //   });

  //   co2.listen((event) {
  //     co2Value = event.snapshot.value.toString();
  //     controller.add(null);
  //   });

  //   dust.listen((event) {
  //     dustValue = event.snapshot.value.toString();
  //     controller.add(null);
  //   });

  //   await for (final _ in controller.stream) {
  //     yield DataModel(co: coValue, co2: co2Value, dust: dustValue);
  //   }
  // }

  Stream<DataModel> getDataCal() async* {
    Stream<DatabaseEvent> co = FirebaseDatabase.instance.ref('/1_CO').onValue;
    Stream<DatabaseEvent> co2 = FirebaseDatabase.instance.ref('/2_CO2').onValue;
    Stream<DatabaseEvent> dust = FirebaseDatabase.instance.ref('/3_DustValue').onValue;
    double coValue = 0.0;
    double co2Value = 0.0;
    double dustValue = 0.0;

    // StreamController to manage updates from all three streams
    StreamController<void> controller = StreamController<void>();

    co.listen((event) {
      coValue = double.parse(event.snapshot.value.toString());
      controller.add(null);
    });

    co2.listen((event) {
      co2Value = double.parse(event.snapshot.value.toString());
      controller.add(null);
    });

    dust.listen((event) {
      dustValue = double.parse(event.snapshot.value.toString());
      controller.add(null);
    });

    await for (final _ in controller.stream) {
      // Calculate total concentration
      double weightedTotal = (coValue / 100) + (co2Value / 100) + (dustValue / 5000);

      // Calculate percentages
      double coPercentage = ((coValue / 100) / weightedTotal) * 100;
      double co2Percentage = ((co2Value / 100) / weightedTotal) * 100;
      double dustPercentage = ((dustValue / 5000) / weightedTotal) * 100;

      yield DataModel(
        co: coPercentage.toStringAsFixed(2),
        co2: co2Percentage.toStringAsFixed(2),
        dust: dustPercentage.toStringAsFixed(2),
      );
    }
  }
}

class DataModel {
  String? co;
  String? co2;
  String? dust;
  DataModel({this.co, this.co2, this.dust});
}
