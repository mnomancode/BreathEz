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
            return Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 70),
              height: 20,
              width: 20,
              child: const CircularProgressIndicator(strokeWidth: 1.5),
            );
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
