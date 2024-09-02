import 'package:breathez/app/data/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/co2_widget.dart';
import 'widgets/co_widget.dart';
import 'widgets/dust_value_widget.dart';
import 'widgets/logout_dialog.dart';
import 'widgets/pie_chart.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/bggood.png',
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          automaticallyImplyLeading: false,
          title: const Text('CO, CO2, and Dust Levels', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => const LogoutDialog());
                },
                icon: Icon(Icons.logout, color: AppColors.primaryColor)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/rectangle-7.png'),
              PieChartSample2(dataModel: DataModel()),

              CoWidget(),
              Co2Widget(),
              DustValueWidget(),
              // StreamBuilder(
              //     stream: controller.getDataCal(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return const CircularProgressIndicator();
              //       }
              //       if (snapshot.hasData) {
              //         return Text(snapshot.data!.co.toString() +
              //             ' - ' +
              //             snapshot.data!.co2.toString() +
              //             ' - ' +
              //             snapshot.data!.dust.toString());
              //       }
              //       return Text('No data');
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
