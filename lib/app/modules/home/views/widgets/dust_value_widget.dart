import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../data/app_colors.dart';

class DustValueWidget extends StatelessWidget {
  const DustValueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance.ref('/3_DustValue').onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            return ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              minTileHeight: 0,
              title: Text(
                'Dust : ' + snapshot.data!.snapshot.value.toString(),
                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              leading: Icon(Icons.drag_indicator_sharp, color: AppColors.primaryColor),
            );
          }

          return Text('No data');
        });
  }
}
