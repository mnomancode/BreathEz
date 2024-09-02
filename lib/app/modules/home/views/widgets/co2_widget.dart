import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../data/app_colors.dart';

class Co2Widget extends StatelessWidget {
  const Co2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance.ref('/2_CO2').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              minTileHeight: 0,
              title: Text(
                'CO2 : ' + snapshot.data!.snapshot.value.toString(),
                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              leading: Icon(Icons.air_sharp, color: AppColors.primaryColor),
            );
          }

          return Text('No data');
        });
  }
}
