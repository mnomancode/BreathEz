import 'package:breathez/app/data/app_colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CoWidget extends StatelessWidget {
  const CoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance.ref('/1_CO').onValue,
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
                'CO : ' + snapshot.data!.snapshot.value.toString(),
                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              leading: Icon(Icons.air_sharp, color: AppColors.primaryColor),
            );
          }

          return Text('No data');
        });
  }
}
